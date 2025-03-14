"""
This is a demo of the Set Covering Problem (SCP) using Gradio.
Code and prototype available at Hugging Face: https://huggingface.co/spaces/mansurarief/data_driven_scp
"""
import numpy as np
import pandas as pd
import pyomo.environ as pyo
import plotly.graph_objects as go
import gradio as gr
import io
import os

"""
Set Covering Problem Mathematical Formulation:

Minimize   ∑(c_i * x_i) for all i in I
Subject to ∑(a_ij * x_i) ≥ 1 for all j in J
           x_i ∈ {0,1} for all i in I
           

Where:
- I is the set of all potential facility locations (sets)
- J is the set of all demand points (elements)
- c_i is the cost of opening a facility at location i
- a_ij is 1 if demand point j can be covered by a facility at location i, 0 otherwise
- x_i is the decision variable: 1 if a facility is opened at location i, 0 otherwise

The objective is to minimize the total cost while ensuring all demand points are covered.
Optional budget constraint: ∑(c_i * x_i) ≤ B, where B is the available budget.
"""

def solve_set_covering_model(excel_file):
    # Read data from the uploaded Excel file
    # 'coverage' sheet contains a binary matrix where rows are sets and columns are elements
    coverage_df = pd.read_excel(excel_file, sheet_name='coverage', index_col=0)
    
    # 'sources' sheet contains the costs and coordinates of each set (W)
    sources_df = pd.read_excel(excel_file, sheet_name='sources', index_col=0)
    
    # 'params' sheet contains general parameters
    params = pd.read_excel(excel_file, sheet_name='params').to_dict(orient='list')
    params = {name_: value_ for name_, value_ in zip(params["name"], params["val"])}
    
    # 'dests' sheet contains coordinates for elements (E)
    dests_df = pd.read_excel(excel_file, sheet_name='dests', index_col=0)
    
    # Initialize the model
    model = pyo.ConcreteModel()
    
    # Define the sets
    model.I = pyo.Set(initialize=sources_df.index.tolist())  # Sets to choose from
    model.J = pyo.Set(initialize=dests_df.index.tolist())  # Elements to cover
    
    # Define the decision variables (binary: 1 if set i is chosen, 0 otherwise)
    model.x = pyo.Var(model.I, domain=pyo.Binary)
    
    # Define the parameters
    # a_ij: 1 if element j is covered by set i, 0 otherwise
    def a_init(model, i, j):
        return coverage_df.loc[i, j]
    model.a = pyo.Param(model.I, model.J, initialize=a_init)
    
    # c_i: cost of selecting set i
    def c_init(model, i):
        return sources_df.loc[i, 'cost']
    model.c = pyo.Param(model.I, initialize=c_init)
    
    # Budget constraint (optional)
    model.budget = pyo.Param(initialize=params.get('budget', float('inf')))
    
    # Define the objective function (minimize the total cost)
    def obj_rule(model):
        return sum(model.c[i] * model.x[i] for i in model.I)
    model.obj = pyo.Objective(rule=obj_rule, sense=pyo.minimize)
    
    # Define the constraints
    # Each element must be covered by at least one selected set
    def coverage_constraint(model, j):
        return sum(model.a[i, j] * model.x[i] for i in model.I) >= 1
    model.coverage_constraint = pyo.Constraint(model.J, rule=coverage_constraint)
    
    # Budget constraint (optional)
    def budget_constraint(model):
        return sum(model.c[i] * model.x[i] for i in model.I) <= model.budget
    
    # Only add budget constraint if a budget is specified and it's not infinite
    if params.get('budget', float('inf')) != float('inf'):
        model.budget_constraint = pyo.Constraint(rule=budget_constraint)
    
    # Solve the model using GLPK
    result = None
    solver_error = None
    
    try:
        # Use GLPK as the primary solver
        solver = pyo.SolverFactory('glpk')
        if solver.available():
            result = solver.solve(model, tee=True)
            output_text = "Using solver: GLPK\n\n"
        else:
            raise Exception("GLPK solver is not available")
    except Exception as e:
        solver_error = str(e)
        raise Exception(f"Failed to solve with GLPK: {solver_error}")
    
    # Generate analysis
    output_text = ""
    output_text += f"Status: {result.solver.status}\n"
    output_text += f"Termination condition: {result.solver.termination_condition}\n"
    output_text += f"Optimal cost: {pyo.value(model.obj)}\n\n"
    
    # Selected sets
    selected_sets = [i for i in model.I if pyo.value(model.x[i]) > 0.5]
    output_text += f"Selected sets ({len(selected_sets)} of {len(model.I)}):\n"
    for i in selected_sets:
        output_text += f"  - Set {i} (Cost: {model.c[i]})\n"
    
    # Check coverage (for validation)
    covered_elements = set()
    for i in selected_sets:
        for j in model.J:
            if model.a[i, j] > 0.5:
                covered_elements.add(j)
    
    output_text += f"\nTotal elements covered: {len(covered_elements)} of {len(model.J)}\n"
    
    # Create Plotly spatial visualization of coverage
    plotly_fig = create_coverage_visualization(sources_df, dests_df, model, selected_sets)
    
    # Create Excel report with detailed results
    results_df = pd.DataFrame({
        "Set": list(model.I),
        "Cost": [model.c[i] for i in model.I],
        "Selected": [pyo.value(model.x[i]) > 0.5 for i in model.I],
    })
    
    # Add the number of elements covered by each set
    results_df["Elements_Covered"] = [sum(model.a[i, j] for j in model.J) for i in model.I]
    
    # Add the specific elements covered by each set (as a string list)
    results_df["Covers_Elements"] = [
        ", ".join([str(j) for j in model.J if model.a[i, j] > 0.5])
        for i in model.I
    ]
    
    # Save to file
    temp_file_path = "set_covering_results.xlsx"
    results_df.to_excel(temp_file_path, index=False)
    
    return output_text, plotly_fig, temp_file_path

def create_coverage_visualization(sources_df, dests_df, model, selected_sets):
    """Create a Plotly visualization showing sets, elements, and coverage."""
    # Create a figure
    fig = go.Figure()
    
    # Map element IDs to their coordinates in dests_df
    element_coords = {}
    
    # Directly use the index of dests_df as element IDs
    for element_id, row in dests_df.iterrows():
        # Element ID is directly from the dataframe index
        if element_id in model.J:
            element_coords[element_id] = (row['x'], row['y'])
    
    # Add all elements as scatter points
    element_x = []
    element_y = []
    element_text = []
    
    for j in model.J:
        if j in element_coords:
            element_x.append(element_coords[j][0])
            element_y.append(element_coords[j][1])
            element_text.append(f"Element: {j}")
    
    fig.add_trace(go.Scatter(
        x=element_x,
        y=element_y,
        mode='markers',
        marker=dict(
            size=10,
            color='blue',
            symbol='circle'
        ),
        name='E (Elements)',
        text=element_text,
        hoverinfo='text'
    ))
    
    # Get coordinates and costs for all sets from sources_df
    set_coords = {}
    set_costs = {}
    
    for i in model.I:
        if i in sources_df.index:
            set_coords[i] = (sources_df.loc[i, 'x'], sources_df.loc[i, 'y'])
            set_costs[i] = sources_df.loc[i, 'cost']
    
    # Prepare data for all sets, but track which ones are selected
    all_set_x = []
    all_set_y = []
    all_set_costs = []
    all_set_text = []
    all_set_is_selected = []  # To control opacity
    
    for i in model.I:
        if i in set_coords:
            all_set_x.append(set_coords[i][0])
            all_set_y.append(set_coords[i][1])
            all_set_costs.append(set_costs[i])
            all_set_text.append(f"Set: {i}, Cost: {set_costs[i]}, {'Selected' if i in selected_sets else 'Not Selected'}")
            all_set_is_selected.append(i in selected_sets)
    
    # Add all sets with cost as color
    if all_set_x:
        # Create opacity array (1.0 for selected, 0.5 for non-selected)
        opacity_array = [1.0 if selected else 0.5 for selected in all_set_is_selected]
        
        fig.add_trace(go.Scatter(
            x=all_set_x,
            y=all_set_y,
            mode='markers',
            marker=dict(
                size=15,
                color=all_set_costs,
                colorscale='Viridis',
                colorbar=dict(
                    title="Cost",
                    thickness=15,
                    len=0.5,
                    y=0.5
                ),
                symbol='square',
                opacity=opacity_array,
                showscale=True
            ),
            name='W (Sets)',
            text=all_set_text,
            hoverinfo='text'
        ))
    
    # Draw coverage lines between selected sets and their covered elements
    for i in selected_sets:
        if i not in set_coords:
            continue
            
        set_x, set_y = set_coords[i]
        
        # Find all elements covered by this set
        for j in model.J:
            if model.a[i, j] > 0.5 and j in element_coords:
                element_x_j, element_y_j = element_coords[j]
                
                # Draw a line from set to element
                fig.add_trace(go.Scatter(
                    x=[set_x, element_x_j],
                    y=[set_y, element_y_j],
                    mode='lines',
                    line=dict(color='rgba(100, 100, 100, 0.3)', width=1),
                    showlegend=False,
                    hoverinfo='none'
                ))
    
    # Collect all x and y values for aspect ratio calculation
    all_x = []
    all_x.extend(element_x)
    all_x.extend(all_set_x)
    
    all_y = []
    all_y.extend(element_y)
    all_y.extend(all_set_y)
    
    if not all_x or not all_y:
        # If no points, set default ranges
        x_min, x_max = 0, 10
        y_min, y_max = 0, 10
    else:
        # Calculate the range for x and y to ensure aspect ratio 1.0
        x_min, x_max = min(all_x), max(all_x)
        y_min, y_max = min(all_y), max(all_y)
    
    # Calculate the range for each axis
    x_range = x_max - x_min
    y_range = y_max - y_min
    
    # Determine the larger range to ensure square aspect ratio
    max_range = max(x_range, y_range)
    
    # Add some padding (10%)
    padding = max_range * 0.1
    
    # Calculate the center points
    x_center = (x_min + x_max) / 2
    y_center = (y_min + y_max) / 2
    
    # Set the axis ranges to be equal
    x_min_new = x_center - (max_range / 2 + padding)
    x_max_new = x_center + (max_range / 2 + padding)
    y_min_new = y_center - (max_range / 2 + padding)
    y_max_new = y_center + (max_range / 2 + padding)
    
    # Update layout
    fig.update_layout(
        title='Set Covering Solution',
        xaxis=dict(
            title='X Coordinate',
            range=[x_min_new, x_max_new],
            constrain='domain'
        ),
        yaxis=dict(
            title='Y Coordinate',
            range=[y_min_new, y_max_new],
            scaleanchor='x',
            scaleratio=1
        ),
        legend_title='Legend',
        hovermode='closest',
        plot_bgcolor='white',
        width=600,
        height=600
    )
    
    return fig

# Create Gradio interface
with gr.Blocks(title="Data-Driven Set Covering") as demo:
    gr.Markdown("# Data-Driven Set Covering Problem Solver")
    
    with gr.Row():
    
        gr.Markdown(r"""
        ## Mathematical Formulation
        
        Minimize   $\sum_{i \in I} c_i \cdot x_i$
        
        Subject to $\sum_{i \in I} a_{ij} \cdot x_i \geq 1$ for all $j \in J$
        
        $x_i \in \{0,1\}$ for all $i \in I$
        
        Where:
        - $I$ is the set of all potential facility locations (sets)
        - $J$ is the set of all demand points (elements)
        - $c_i$ is the cost of opening a facility at location $i$
        - $a_{ij}$ is 1 if demand point $j$ can be covered by a facility at location $i$, 0 otherwise
        - $x_i$ is the decision variable: 1 if a facility is opened at location $i$ , 0 otherwise
        """, latex_delimiters=[ {"left": "$", "right": "$", "display": False }])
    
        gr.Markdown("""
        ## Instructions
        Upload an Excel file with the following sheets (see [example file](https://docs.google.com/spreadsheets/d/1O-JK-hvN7tszzRIGi3khPkhxrnebLXZ5KnPRDbQjaLA/edit?usp=sharing)):
        - 'coverage' sheet: A binary matrix where rows are sets and columns are elements
        - 'sources' sheet: Contains the costs and coordinates (x, y) of each set W (with Set IDs as index)
        - 'dests' sheet: Contains coordinates for elements E with columns: name, x, and y
        - 'params' sheet: Contains parameters like 'budget' (optional)
        """)
        
    with gr.Row():
        input_file = gr.File(label="Upload Excel File")
        submit_btn = gr.Button("Solve Set Covering Problem")
    
    with gr.Row():
        with gr.Column(scale=1):
            output_text = gr.Textbox(label="Optimization Results", lines=20)
            output_file = gr.File(label="Download Results")
        with gr.Column(scale=2):
            output_plotly = gr.Plot(label="Set Covering Visualization")
    
    submit_btn.click(
        solve_set_covering_model,
        inputs=[input_file],
        outputs=[output_text, output_plotly, output_file]
    )

# Launch the app
if __name__ == "__main__":
    demo.launch()
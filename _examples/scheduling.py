"""
This is a demo of the Shift Scheduling Problem using Gradio.
Code and prototype available at Hugging Face: https://huggingface.co/spaces/mansurarief/data_driven_scheduling
"""
import numpy as np
import pandas as pd
import pyomo.environ as pyo
import plotly.graph_objects as go
import plotly.express as px
import gradio as gr
import io
import os
from datetime import datetime, timedelta

"""
Shift Scheduling Problem Mathematical Formulation:

Minimize   ∑(c_ij * x_ij) for all i in I, j in J
Subject to ∑(x_ij) = 1 for all i in I (each employee gets exactly one shift)
           ∑(x_ij) >= r_j for all j in J (each shift meets minimum staffing requirement)
           x_ij ∈ {0,1} for all i in I, j in J
           
Where:
- I is the set of employees
- J is the set of shifts
- c_ij is the cost of assigning employee i to shift j
- r_j is the minimum staffing requirement for shift j
- x_ij is the decision variable: 1 if employee i is assigned to shift j, 0 otherwise

The objective is to minimize the total assignment cost while meeting staffing requirements.
"""

def solve_shift_scheduling_model(excel_file):
    # Read data from the uploaded Excel file
    # 'costs' sheet contains the cost matrix for assigning employees to shifts
    costs_df = pd.read_excel(excel_file, sheet_name='costs', index_col=0)
    
    # 'employees' sheet contains information about employees
    employees_df = pd.read_excel(excel_file, sheet_name='employees', index_col=0)
    
    # 'shifts' sheet contains information about shifts
    shifts_df = pd.read_excel(excel_file, sheet_name='shifts', index_col=0)
    
    # 'params' sheet contains general parameters (optional)
    try:
        params = pd.read_excel(excel_file, sheet_name='params').to_dict(orient='list')
        params = {name_: value_ for name_, value_ in zip(params["name"], params["val"])}
    except:
        params = {}
    
    # Initialize the model
    model = pyo.ConcreteModel()
    
    # Define the sets
    model.I = pyo.Set(initialize=employees_df.index.tolist())  # Employees
    model.J = pyo.Set(initialize=shifts_df.index.tolist())  # Shifts
    
    # Define the decision variables
    # x_ij: 1 if employee i is assigned to shift j, 0 otherwise
    model.x = pyo.Var(model.I, model.J, domain=pyo.Binary)
    
    # Define the parameters
    # c_ij: cost of assigning employee i to shift j
    def c_init(model, i, j):
        return costs_df.loc[i, j]
    model.c = pyo.Param(model.I, model.J, initialize=c_init)
    
    # r_j: minimum staff required for shift j
    def r_init(model, j):
        return shifts_df.loc[j, 'min_staff']
    model.r = pyo.Param(model.J, initialize=r_init)
    
    # Define the objective function (minimize total assignment cost)
    def obj_rule(model):
        return sum(model.c[i, j] * model.x[i, j] for i in model.I for j in model.J)
    model.obj = pyo.Objective(rule=obj_rule, sense=pyo.minimize)
    
    # Define the constraints
    # Each employee is assigned to exactly one shift
    def one_shift_per_employee(model, i):
        return sum(model.x[i, j] for j in model.J) == 1
    model.one_shift_constraint = pyo.Constraint(model.I, rule=one_shift_per_employee)
    
    # Each shift meets minimum staffing requirements
    def minimum_staff_constraint(model, j):
        return sum(model.x[i, j] for i in model.I) >= model.r[j]
    model.min_staff_constraint = pyo.Constraint(model.J, rule=minimum_staff_constraint)
    
    # Optional: maximum staff per shift constraint (if specified in shifts dataframe)
    if 'max_staff' in shifts_df.columns:
        def max_staff_constraint(model, j):
            return sum(model.x[i, j] for i in model.I) <= shifts_df.loc[j, 'max_staff']
        model.max_staff_constraint = pyo.Constraint(model.J, rule=max_staff_constraint)
    
    # Optional: Employee preferences constraint (if preference matrix is given)
    if 'preferences' in params.get('include', []):
        try:
            # Read preference matrix (1 = preferred, 0 = not preferred)
            prefs_df = pd.read_excel(excel_file, sheet_name='preferences', index_col=0)
            
            # Define minimum preferred shifts parameter
            min_preferred = params.get('min_preferred_pct', 0)
            
            # Add constraint: each employee gets at least min_preferred% of their preferred shifts
            def preference_constraint(model, i):
                preferred_shifts = [j for j in model.J if prefs_df.loc[i, j] == 1]
                if not preferred_shifts:  # Skip if employee has no preferences
                    return pyo.Constraint.Skip
                return sum(model.x[i, j] for j in preferred_shifts) >= min_preferred
            
            model.preference_constraint = pyo.Constraint(model.I, rule=preference_constraint)
        except:
            pass  # If preferences sheet doesn't exist, skip this constraint
    
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
    output_text += f"Optimal total cost: {pyo.value(model.obj):.2f}\n\n"
    
    # Create a dataframe with assignments
    assignments = []
    for i in model.I:
        assigned_shift = None
        for j in model.J:
            if pyo.value(model.x[i, j]) > 0.5:
                assigned_shift = j
                break
        
        if assigned_shift is not None:
            employee_data = {
                'Employee_ID': i,
                'Name': employees_df.loc[i, 'name'] if 'name' in employees_df.columns else i,
                'Assigned_Shift': assigned_shift,
                'Shift_Start': shifts_df.loc[assigned_shift, 'start_time'],
                'Shift_End': shifts_df.loc[assigned_shift, 'end_time'],
                'Assignment_Cost': model.c[i, assigned_shift]
            }
            assignments.append(employee_data)
    
    assignments_df = pd.DataFrame(assignments)
    
    # Summary by shift
    output_text += "Staff Assignments by Shift:\n"
    shift_summary = {}
    for j in model.J:
        assigned_employees = [i for i in model.I if pyo.value(model.x[i, j]) > 0.5]
        shift_summary[j] = {
            'Assigned_Staff': len(assigned_employees),
            'Min_Required': model.r[j],
            'Employees': ', '.join([str(employees_df.loc[i, 'name']) if 'name' in employees_df.columns else str(i) for i in assigned_employees])
        }
        output_text += f"  Shift {j}: {len(assigned_employees)} staff assigned (minimum: {model.r[j]})\n"
        output_text += f"    Employees: {shift_summary[j]['Employees']}\n"
    
    shift_summary_df = pd.DataFrame(shift_summary).T
    shift_summary_df.index.name = 'Shift'
    shift_summary_df = shift_summary_df.reset_index()
    
    # Create visualization of the schedule
    fig = create_schedule_visualization(assignments_df, shifts_df)
    
    # Save results to Excel
    temp_file_path = "shift_scheduling_results.xlsx"
    with pd.ExcelWriter(temp_file_path) as writer:
        assignments_df.to_excel(writer, sheet_name='Assignments', index=False)
        shift_summary_df.to_excel(writer, sheet_name='Shift_Summary', index=False)
    
    return output_text, fig, temp_file_path

def create_schedule_visualization(assignments_df, shifts_df):
    """Create a Plotly visualization showing the shift schedule."""
    # Create a dataframe for visualization
    gantt_data = []
    
    # Create a reference date for visualization (doesn't matter which date)
    base_date = datetime.today().replace(hour=0, minute=0, second=0, microsecond=0)
    
    for _, row in assignments_df.iterrows():
        # Get shift start and end times
        start_hour = int(shifts_df.loc[row['Assigned_Shift'], 'start_time'])
        end_hour = int(shifts_df.loc[row['Assigned_Shift'], 'end_time'])
        
        # Create datetime objects for start and end
        start_time = base_date + timedelta(hours=start_hour)
        
        # Handle overnight shifts (where end < start)
        if end_hour < start_hour:
            end_time = base_date + timedelta(days=1, hours=end_hour)
        else:
            end_time = base_date + timedelta(hours=end_hour)
        
        gantt_data.append({
            'Employee': row['Name'] if 'Name' in assignments_df.columns else row['Employee_ID'],
            'Start': start_time,
            'Finish': end_time,
            'Shift': row['Assigned_Shift']
        })
    
    gantt_df = pd.DataFrame(gantt_data)
    
    # Create a color map for shifts
    shift_colors = px.colors.qualitative.Plotly[:len(shifts_df)]
    color_map = {shift: color for shift, color in zip(shifts_df.index, shift_colors)}
    
    # Create Gantt chart
    fig = px.timeline(
        gantt_df, 
        x_start='Start', 
        x_end='Finish', 
        y='Employee',
        color='Shift',
        title='Employee Shift Schedule',
        color_discrete_map=color_map
    )
    
    # Update layout for better time display
    fig.update_layout(
        xaxis_title='Time',
        yaxis_title='Employee',
        yaxis={'categoryorder': 'category ascending'},
        legend_title='Shift',
        height=600,
        xaxis={
            'tickformat': '%H:%M',
            'dtick': 3600000,  # 1 hour in milliseconds
        }
    )
    
    # Add vertical lines at shift boundaries for easier visualization
    for _, row in shifts_df.iterrows():
        start_hour = int(row['start_time'])
        start_time = base_date + timedelta(hours=start_hour)
        
        fig.add_vline(
            x=start_time,
            line_dash='dash',
            line_color='gray',
            opacity=0.5
        )
    
    return fig

# Create Gradio interface
with gr.Blocks(title="Data-Driven Shift Scheduling") as demo:
    gr.Markdown("# Data-Driven Shift Scheduling")
    
    with gr.Row():
        gr.Markdown(r"""
        ## Mathematical Formulation
        
        Minimize   $\sum_{i \in I, j \in J} c_{ij} \cdot x_{ij}$
        
        Subject to:
        - $\sum_{j \in J} x_{ij} = 1$ for all $i \in I$ (each employee gets exactly one shift)
        - $\sum_{i \in I} x_{ij} \geq r_j$ for all $j \in J$ (each shift meets minimum staffing requirement)
        - $x_{ij} \in \{0,1\}$ for all $i \in I, j \in J$
        
        Where:
        - $I$ is the set of employees
        - $J$ is the set of shifts
        - $c_{ij}$ is the cost of assigning employee $i$ to shift $j$
        - $r_j$ is the minimum staffing requirement for shift $j$
        - $x_{ij}$ is the decision variable: 1 if employee $i$ is assigned to shift $j$, 0 otherwise
        """, latex_delimiters=[{"left": "$", "right": "$", "display": False}])
        
        gr.Markdown("""
        ## Instructions
        Upload an Excel file with the following sheets ([template data](https://docs.google.com/spreadsheets/d/1trr2j4iOFQGwQWevRv01y5JJ--WP7ECx/edit?usp=sharing&ouid=108951544316632731762&rtpof=true&sd=true)):
        - 'costs' sheet: Cost matrix for assigning employees to shifts (employees as rows, shifts as columns)
        - 'employees' sheet: Information about employees (ID as index, with employee attributes)
        - 'shifts' sheet: Information about shifts (ID as index, with min_staff, start_time, and end_time)
        - 'params' sheet (optional): General parameters for the model
        - 'preferences' sheet (optional): Employee shift preferences (1=preferred, 0=not preferred)
        """)
    
    with gr.Row():
        input_file = gr.File(label="Upload Excel File")
        submit_btn = gr.Button("Solve Shift Scheduling Problem")
    
    with gr.Row():
        with gr.Column(scale=1):
            output_text = gr.Textbox(label="Optimization Results", lines=20)
            output_file = gr.File(label="Download Results")
        with gr.Column(scale=2):
            output_plot = gr.Plot(label="Shift Schedule Visualization")
    
    submit_btn.click(
        solve_shift_scheduling_model,
        inputs=[input_file],
        outputs=[output_text, output_plot, output_file]
    )

# Launch the app
if __name__ == "__main__":
    demo.launch()
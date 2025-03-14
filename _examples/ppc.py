"""
This is a demo of the Production Planning Problem (PPC) using Gradio.
Code and prototype available at Hugging Face: https://huggingface.co/spaces/mansurarief/data_driven_ppc
"""
import numpy as np
import pandas as pd
import pyomo.environ as pyo
import matplotlib.pyplot as plt
import gradio as gr
import io
import os

def solve_production_model(excel_file):

    # Read data from the uploaded Excel file
    df = pd.read_excel(excel_file, sheet_name='data', index_col=0).to_dict()
    params = pd.read_excel(excel_file, sheet_name='params').to_dict(orient='list')
    params = {name_: value_ for name_, value_ in zip(params["name"], params["val"])}

    # Initialize the model
    model = pyo.ConcreteModel()
    
    # Get number of products from params
    num_products = int(params.get('num_products', 3))
    
    # Define the set of products
    model.I = pyo.Set(initialize=range(1, num_products + 1))
    
    # Define the decision variables
    model.x = pyo.Var(model.I, domain=pyo.Reals)
    
    # Define the parameters
    model.r = pyo.Param(model.I, initialize=df['revenue'])
    model.c = pyo.Param(model.I, initialize=df['cost'])
    model.p = pyo.Param(model.I, initialize=df['production_capacity'])
    model.b = pyo.Param(initialize=params['budget'])
    model.s = pyo.Param(initialize=params['capacity'])
    
    # Define the objective function
    def f(model):
        return sum((model.r[i] - model.c[i]) * model.x[i] for i in model.I)
    model.obj = pyo.Objective(rule=f, sense=pyo.maximize)
    
    # Define the constraints
    def budget_constraint(model):
        return sum(model.c[i] * model.x[i] for i in model.I) <= model.b
    model.budget_constraint = pyo.Constraint(rule=budget_constraint)
    
    def storage_capacity(model):
        return sum(model.x[i] for i in model.I) <= model.s
    model.storage_capacity = pyo.Constraint(rule=storage_capacity)
    
    def production_capacity(model, i):
        return model.x[i] <= model.p[i]
    model.production_capacity = pyo.Constraint(model.I, rule=production_capacity)
    
    def nonnegative_domain(model, i):
        return model.x[i] >= 0
    model.nonnegative_domain = pyo.Constraint(model.I, rule=nonnegative_domain)
    
    # Try multiple solvers in order of preference
    solvers_to_try = ['glpk']
    result = None
    solver_error = None
    
    for solver_name in solvers_to_try:
        try:
            solver = pyo.SolverFactory(solver_name)
            if solver.available():
                result = solver.solve(model)
                output_text = f"Using solver: {solver_name}\n\n"
                break
        except Exception as e:
            solver_error = str(e)
            continue
    
    if result is None:
        raise Exception(f"No available solvers found. Last error: {solver_error}\nTried: {', '.join(solvers_to_try)}")
    
    # Generate analysis
    output_text = ""
    output_text += f"Status: {result.solver.status}\n"
    output_text += f"Termination condition: {result.solver.termination_condition}\n"
    output_text += f"Optimal value: {pyo.value(model.obj)}\n"

    for i in model.I:
        output_text += f"Product {i}: {model.x[i]()}\n"

    
    # Create simplified visualization - just the production quantities
    fig, ax = plt.subplots(figsize=(10, 6))
    
    # Bar chart of production quantities
    products = [f"Product {i}" for i in model.I]
    quantities = [pyo.value(model.x[i]) for i in model.I]
    ax.bar(products, quantities)
    ax.set_title('Optimal Production Quantities')
    ax.set_ylabel('Quantity')
    # Adjust x-axis rotation if we have many products
    if len(products) > 100:
        # Show only every 50th product on x-axis
        keep_indices = list(range(0, len(products), 50))
        # Always include the last product
        if (len(products) - 1) not in keep_indices:
            keep_indices.append(len(products) - 1)
        
        # Get the labels to keep
        keep_labels = [products[i] for i in keep_indices]
        
        # Set the visible ticks and labels
        ax.set_xticks([i for i in keep_indices])
        ax.set_xticklabels(keep_labels)
        plt.setp(ax.get_xticklabels(), rotation=45, ha='right')
    elif len(products) > 5:
        plt.setp(ax.get_xticklabels(), rotation=45, ha='right')
    
    plt.tight_layout()
    
    # Create Excel report - keep all the columns for the Excel output
    results_df = pd.DataFrame({
        "Product": list(model.I),
        "Production Quantity": [model.x[i]() for i in model.I],
        "Unit Revenue": [model.r[i] for i in model.I],
        "Unit Cost": [model.c[i] for i in model.I],
        "Total Profit": [(model.r[i] - model.c[i]) * pyo.value(model.x[i]) for i in model.I]
    })
    
    # Save to in-memory bytes buffer
    temp_file_path = "optimization_results.xlsx"
    results_df.to_excel(temp_file_path, index=False)
    
    return output_text, fig, temp_file_path
    
# Create Gradio interface
with gr.Blocks(title="Data Driven PPC") as demo:
    gr.Markdown("# Data Driven PPC (Analytics Projects)")
    gr.Markdown("""
    Upload an Excel file with two sheets ([template here](https://docs.google.com/spreadsheets/d/1rPRaSdfid14Omo5d09jetije-MEeUAbzBSsuBO5ZFvI/edit?usp=sharing)):
    - 'data' sheet with columns for revenue, cost, and production_capacity (with Product IDs as index)
    - 'params' sheet with columns for name and val (containing 'budget' and 'capacity' parameters)
    """)
    
    with gr.Row():
        with gr.Column():
            input_file = gr.File(label="Upload Excel File")
            submit_btn = gr.Button("Optimize Production Plan")
        
    with gr.Row():
        with gr.Column():
            output_text = gr.Textbox(label="Optimization Results", lines=20)
            output_plot = gr.Plot(label="Visualization")
            output_file = gr.File(label="Download Results")
    
    submit_btn.click(
        solve_production_model,
        inputs=[input_file],
        outputs=[output_text, output_plot, output_file]
    )

# Launch the app
if __name__ == "__main__":
    demo.launch()
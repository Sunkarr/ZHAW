"""
Prog 1
W04
Aufgabe 2.2 Cost calculation (selective: WI, DS)

Author: Jonas Bratschi (bratsjon)
Date: 17.10.2023
"""

# Costs (per unit)
costmachine_a = 25000
costmachine_b = 40000
costmaterial_a1 = 335
costmaterial_a2 = 1520
costmaterial_b1 = 865

# Units used per machine
machine_a_material_a1 = 47
machine_a_material_a2 = 119
machine_b_material_b1 = 159

# Initial costs per machine
machine_a = costmachine_a + (machine_a_material_a1 * costmaterial_a1) + (machine_a_material_a2 * costmaterial_a2)
machine_b = costmachine_b + (machine_b_material_b1 * costmaterial_b1)

# Labour costs (per hour)
cost_specialist_a = 150
cost_specialist_b = 175
cost_project_manager = 200

# Inputs
inputmachine = input("Input machine 'A' or 'B':")
inputbudget = input("Input your budget:")
inputdurationinm = input("Labour in month:")

# Error outputs in case input is invalid
if inputmachine != "A" and inputmachine != "B":
    print("Error: please type for Input machine 'A' or 'B'")
if not (inputbudget.isdigit() and inputbudget > "0"):
    print("Error: please type an integer (>0) for Input your budget")
if not (inputdurationinm.isdigit() and inputdurationinm > "0"):
    print("Error: please type an integer (>0) for Labour in month")

# Convert inputvariables into integers
inputbudget = int(inputbudget)
inputdurationinm = int(inputdurationinm)

# Total cost Project manager
total_cost_project_manager = (cost_project_manager * inputdurationinm * 42)

# Costs machine A
if inputmachine == "A":
    cost = machine_a + total_cost_project_manager
    workinghours = (inputbudget - total_cost_project_manager) / cost_specialist_a

    # Errors iv invalid conditions
    if ((total_cost_project_manager/(total_cost_project_manager+(inputbudget - cost))*100) > 12
            and (total_cost_project_manager / (total_cost_project_manager + (inputbudget - cost)) * 100) < 8):
        print("Error: following condition is not true: Project management cost 8< and >12% of total labour cost")
    elif (inputbudget/costmachine_a * 100) < 25:
        print("Error: following condition is not true: The machine and material costs >25% of budget")

    # Final calculation
    else:
        print("\n")
        print("Cost overwiev:")
        print("Costs for machine A inclusive Material:", machine_a)
        print("Costs for project manager:", total_cost_project_manager)
        print("-----------------")
        print("Subtotal:", cost)
        print("-----------------")
        print("Remaining budget for specialist A:", (inputbudget - cost),)
        print("(equals", ((inputbudget - cost)/cost_specialist_a), "workinghours)")
        print("-----------------")
        print("Total labour costs:", (total_cost_project_manager+(inputbudget - cost)))
        print("Specialist A's costs in relation to total labour costs:",
              (inputbudget - cost)/(total_cost_project_manager+(inputbudget - cost))*100, "%")
        print("Project managers costs in relation to total labour costs:",
              total_cost_project_manager/(total_cost_project_manager+(inputbudget - cost))*100, "%")

# Costs machine B
else:
    cost = machine_b + total_cost_project_manager
    workinghours = (inputbudget - total_cost_project_manager) / cost_specialist_b

    # Errors iv invalid conditions
    if ((total_cost_project_manager/(total_cost_project_manager+(inputbudget - cost))*100) > 12
            and (total_cost_project_manager / (total_cost_project_manager + (inputbudget - cost)) * 100) < 8):
        print("Error: following condition is not true: Project management cost 8< and >12% of total labour cost")
    elif (inputbudget / costmachine_b * 100) < 25:
        print("Error: following condition is not true: The machine and material costs >25% of budget")

    # Final calculation
    else:
        print("\n")
        print("Cost overview:")
        print("Costs for machine B inclusive Material:", machine_b)
        print("Costs for project manager:", total_cost_project_manager)
        print("-----------------")
        print("Subtotal:", cost)
        print("-----------------")
        print("Remaining budget for specialist B:", (inputbudget - cost), )
        print("(equals", ((inputbudget - cost) / cost_specialist_b), "working hours)")
        print("-----------------")
        print("Total labor costs:", (total_cost_project_manager + (inputbudget - cost)))
        print("Specialist B's costs in relation to total labor costs:",
              (inputbudget - cost) / (total_cost_project_manager + (inputbudget - cost)) * 100, "%")
        print("Project manager's costs in relation to total labor costs:",
              total_cost_project_manager / (total_cost_project_manager + (inputbudget - cost)) * 100, "%")

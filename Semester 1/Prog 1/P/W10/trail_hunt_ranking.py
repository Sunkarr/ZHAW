"""
Prog 1
W10
G5 Trail Hunt–RanglisteStudiengänge
Author: Jonas Bratschi (bratsjon)
Date: 30.11.2023
"""

"""Disclaimer:
I have seen other students gpx-files have another data structure, which my code can't read properly.
But my code works at least for the data structure in the files 'bratsjon.gpx' and selesaro.gpx'.
These files are exported from Strava respectively Garmin which are well known and widespread fitnesstrackers."""

import trail_hunt
import os

# Specify the path to the folder
folder_path = './'
all_calculations = []
error_files = []

# Variables to calculate and their corresponding indices
variables = [
    ("elevation delta [m]", 1),
    ("max speed [km/h]", 2),
    ("average speed [km/h]", 3),
    ("total time [h]", 4),
    ("total distance [m]", 5),
]

# Iterate through all files in the folder
for file in os.listdir(folder_path):
    file_path = os.path.join(folder_path, file)

    # Check if it is a file and has a .gpx extension
    if os.path.isfile(file_path) and file.endswith('.gpx'):
        try:
            # Call the trail_hunt function on each .gpx file and store the result
            result = trail_hunt.trail_hunt(file_path)
            # Append a tuple with file name and variables to the list
            all_calculations.append((file,) + result)
        except Exception as e:
            print(f"Error processing {file}: {e}")
            error_files.append(file)

# Create a ranking based on the variables in the result tuple
with open(os.path.join(folder_path, "ranking.txt"), 'w') as f:
    for variable_name, variable_index in variables:
        sorted_calculations = sorted(all_calculations, key=lambda x: x[variable_index] if len(x) > variable_index else 0, reverse=True)

        # Print the ranking and store it in "ranking.txt"
        f.write(f"\nRanking based on {variable_name}:\n")
        for i, item in enumerate(sorted_calculations):
            f.write(f"{i + 1}. {item[0]} - {item[variable_index] if len(item) > variable_index else 'N/A'}\n")

    # Add a line to indicate the count of evaluated tuples
    f.write(f"\nNumber of evaluated .gpx files: {len(all_calculations)}\n")

    # Add a line to show files that produced errors
    if error_files:
        f.write(f"\nNumber of files with errors: {len(error_files)}\n")
        f.write("Files with errors:\n")
        for error_file in error_files:
            f.write(f"{error_file}\n")

print("Ranking has been generated and stored in 'ranking.txt'.")

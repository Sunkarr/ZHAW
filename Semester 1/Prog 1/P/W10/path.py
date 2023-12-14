# Use the os.pathPython module
import os
# Get the current directory
os.getcwd()
# Compose path
os.path.join(<my_directory>, <my_sub_directory>)
# Convert a relative path to an absolute path
os.path.abspath(<a_relative_path>)
# List files in directory
os.listdir(<a_path>)
# Example: path to file test.txt, one directory up from current working directory:
path_to_file = os.path.abspath(os.path.join(os.getcwd(), '..', 'test.txt'))
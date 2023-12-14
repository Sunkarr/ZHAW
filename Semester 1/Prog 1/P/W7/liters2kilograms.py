"""
Prog 1
W05
P04, Aufgabe 1.1 Rewrite existing code

Author: Jonas Bratschi (bratsjon)
Date: 04.11.2023
"""

# define the function and its behaviour
def convert(liters, density):
    """
    :param liters: float, input volume in liters
    :param density: float, input density in kg/l
    :return: float, output in kg
    """
    weight = liters * density
    return weight

# call the function
function_response = convert(100, 7500)

# do whatever you want with the function response
print(function_response)

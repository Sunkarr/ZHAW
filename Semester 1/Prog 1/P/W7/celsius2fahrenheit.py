"""
Prog 1
W05
P04, Aufgabe 1.1 Rewrite existing code

Author: Jonas Bratschi (bratsjon)
Date: 04.11.2023
"""

# define the function and its behaviour
def convert(celsius):
    """
    :param celsius: float, input in degree celsius
    :return: float, degree fahreinheit
    """
    d = (celsius * 1.8) + 32

    return d

# call the function
function_response = convert(100)

# do whatever you want with the function response
print(function_response)
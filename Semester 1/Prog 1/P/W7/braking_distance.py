"""
Prog 1
W05
P04, Aufgabe 1.1 Rewrite existing code

Author: Jonas Bratschi (bratsjon)
Date: 04.11.2023
"""

# define the function and its behaviour
def calc_distance(v0, mu):
    """
    :param v0: float, input velocity in km/h
    :param mu: float, friction resistance (coefficient)
    :return: float, braking distance in m
    """
    g = 9.81
    v0m = v0 / 3.6
    d = (0.5 * (v0m ** 2)) / (mu * g)

    return d

# call the function
function_response = calc_distance(100, 0.3)

# do whatever you want with the function response
print(function_response)
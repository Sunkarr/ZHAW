"""
Prog 1
W05
P04, Aufgabe 1.1 Rewrite existing code

Author: Jonas Bratschi (bratsjon)
Date: 04.11.2023
"""

# define the function and its behaviour
def distance(x1, y1, x2, y2):
    """
    :param x1: x coordinate Plane 1
    :param y1: y coordinate Plane 1
    :param x2: x coordinate Plane 2
    :param y2: x coordinate Plane 2
    :return: distance between plane 1 and 2
    """
    distance = ((x2 - x1) ** 2 + (y2 - y1) ** 2) ** 0.5

    return distance

# call the function
function_response = distance(100, 100, 200, 200)

# do whatever you want with the function response
print(function_response)
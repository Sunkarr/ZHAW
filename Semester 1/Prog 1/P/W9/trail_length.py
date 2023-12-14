"""
Prog 1
W08
P05, 1.1 Trail Length
Author: Jonas Bratschi (bratsjon)
Date: 17.11.2023
"""

trail = [(142.492, 208.536),
        (142.658, 207.060),
        (143.522, 205.978),
        (145.009, 205.546)]

def distance_between_two_points (p1, p2):
    dist = ((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2)**0.5
    return dist


def pathlength(trail):
    length = 0
    for i in range(len(trail) - 1):
        length += distance_between_two_points(trail[i], trail[i + 1])
    return length


"""
Prog 1
604
Aufgabe 2.1 Domino

Author: Jonas Bratschi (bratsjon)
Date: 28.10.2023
"""

for i in range(0, 7, 1):
    for j in range(0, 7, 1):
        if i <= j:
            print("(", i, "|", j, ")", sep='', end=',')

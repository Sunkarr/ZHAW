"""
Prog 2
W05
Aufgabe 1.1 Draw a match

Author: Jonas Bratschi (bratsjon)
Date: 24.02.2024
"""

import random

print("1: start game")
print("2: Quit game")
menu_number = int(input("Select your mode: "))
start_number = random.randint(9, 20)
while menu_number != 2:
    match_horizontal = "=======0"
    for line in range(start_number):
        print(match_horizontal)

"""Test
"""
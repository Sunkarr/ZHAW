# -*- coding: utf-8 -*-
"""
Created on Sat Sep 30 13:18:52 2023

@author: jonas
"""

# Aufgabe 4.4

# Inputs

flugzeug1x = float(input("X Koordinate Flugzeug 1 (km):"))
flugzeug1y = float(input("Y Koordinate Flugzeug 1 (km):"))
flugzeug2x = float(input("X Koordinate Flugzeug 2 (km):"))
flugzeug2y = float(input("Y Koordinate Flugzeug 2 (km):"))

# Calculation

if flugzeug1x == flugzeug2x and flugzeug1y == flugzeug2y:
    print("Flugzeuge haben dieselbe Position.")
else:
    distance = ((flugzeug2x - flugzeug1x)**2 + (flugzeug2y - flugzeug1y)**2)**0.5
    print("Der Abstand zwischen den beiden Flugzeugen beträgt:", distance, "km")

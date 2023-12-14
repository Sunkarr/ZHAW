"""
Prog 1
W05
Aufgabe 1.4 Compute Pi

Author: Jonas Bratschi (bratsjon)
Date: 21.10.2023
"""
# Import library
import math

"""
The total calculation is sliced into 2 Terms for easier calculation (a and b (everything before the loop -> a))
"""

# Variables
term_a = 0
term_b = 0

# Calculation of term_a
term_a += ((2*(2**0.5))/9801)

# Calculation of term_b
n = 0
while True:
    # Calculate the terms for term_b
    term = (math.factorial(4 * n) / (math.factorial(n) ** 4)) * (1103 + 26390 * n) / (396 ** (4 * n))

    # Add the term to term_b
    term_b += term

    # Check if the last term is smaller than 1e-15
    if term < 1e-15:
        break

    n += 1

# End calculation and print
calculated_pi = 1/(term_a*term_b)
calculated_pi = round(calculated_pi, 5)
print(calculated_pi)

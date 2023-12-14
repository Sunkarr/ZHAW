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
while term_b < 1e-15:
    # Calculate the terms for term_b
    term_b += (math.factorial(4 * n) / (math.factorial(n) ** 4)) * (1103 + 26390 * n) / (396 ** (4 * n))
    n += 1

# End calculation and print
calculated_pi = 1/(term_a*term_b)
print(calculated_pi)

"""
Prog 1
W04
Aufgabe 2.4 Rock Paper Scissors

Author: Jonas Bratschi (bratsjon)
Date: 17.10.2023
"""

# Import library
import random

# User input
human_choice = input("Choose rock, paper or scissors,"
                    "\ntype following shortcuts according to your choice:"
                    "\nRock -> r"
                    "\nPaper -> p"
                    "\nScissors -> s"
                    "\nInput:")

# Check input
if human_choice not in ('r', 'p', 's'):
        print("Error: please type 'r', 'p', or 's' for input.")
        sys.exit(1)

# Confirmation of user Input
if human_choice == "r":
    human_choice = 1
    print("Your choice: Rock")
elif human_choice == "p":
    human_choice = 2
    print("Your choice: Paper")
elif human_choice == "s":
    human_choice = 3
    print("Your choice: Scissors")

# Computer choice
random_number = int(random.uniform(1.0, 4.0))

# Rock
if random_number == 1:
    print("The computer chose: Rock")
# Paper
elif random_number == 2:
    print("The computer chose: Paper")
# Scissors
elif random_number == 3:
    print("The computer chose: Scissors")

# Result
x = "Result of the game:"
if human_choice == random_number:
    print(x, "tie")
elif human_choice == 1 and random_number == 3:
    print(x, "you win")
elif human_choice == 2 and random_number == 1:
    print(x, "you win")
elif human_choice == 3 and random_number == 2:
    print(x, "you win")
else:
    print(x, "you loose")

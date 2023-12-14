"""
Prog 1
W04
Aufgabe 2.4 Rock Paper Scissors

Author: Jonas Bratschi (bratsjon)
Date: 17.10.2023
"""

# Import library
import random

'''Fabio: Make sure that the User knows what kind of game he's playing
          for Example use print("Welcome to Rock-Paper-Scissors game!")'''

#Description
print("You are playing rock, paper, scissors against the computer")

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
        exit(1)

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

'''Simone: you could use only one <<elif>> by adding the second <<elif expression>> under the first one
    -> Bratschi: Ich lasse das, so sind Bedingungen klarer definiert'''

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
    
''' Simone: If you want to play again you could add the following code to restart the game:
    
    play_again = input("Play again? (yes/no): ").lower()
    if play_again != "yes":
    Bratschi: -> this is not part of the taks ;) '''

    
    

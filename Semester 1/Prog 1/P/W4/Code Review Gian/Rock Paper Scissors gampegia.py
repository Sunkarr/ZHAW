# -*- coding: utf-8 -*-

"""
Code Review: mit Kommentar #bratsjon ...
"""

"""
---------------------------
|   Author: Gamper Gian  |
|   Date: 07.10.2023    |
------------------------

Exercise 2.4 Rock Paper Scissors
------
Write a program for the rock-paper-scissors game where one person is simulated by the computer and the other is the actual user.
Rock-paper-scissors is usually played by two people, where players simultaneously form one of
three shapes with an outstretched hand. The rules are
• the "rock" beats scissors
• the "scissors" beat paper and
• the "paper" beats rock;
• if both players throw the same shape, the game is tied.
Hints:
• Just simulating one round of the game is enough; optionally, you can of course enhance
your implementation to play until one party has, say, 3 wins.
• Generate a random number to simulate the computers choice.

"""
# Import necessary modules
import random

# Initialize scores for user and computer
user_score = 0
computer_score = 0

# Flag to determine if the game is still running
game_running = True

# Game loop
while game_running:
    # Display game title
    print("\nRock-Paper-Scissors Game:")

    # Get user's choice
    # bratsjon: Spezifiere den user Input (Bsp. s für Scissors) so weiss ich nicht was mein Input sein soll
    user = input("Enter your choice (rock, paper, scissors) : ").lower()

    # Check if the user's choice is valid
    if user in ["rock", "paper", "scissors"]:
        # List of computer's possible choices
        comp_choices = ["rock", "paper", "scissors"]

        # Randomly select computer's choice
        comp = random.choice(comp_choices)
        print(f"Computer chose: {comp}")

        # Determine the winner
        if user == comp:
            result = "It's a tie!"
        elif (user == "rock" and comp == "scissors") or \
                (user == "scissors" and comp == "paper") or \
                (user == "paper" and comp == "rock"):
            result = "User wins!"
            user_score += 1
        else:
            result = "Computer wins!"
            computer_score += 1

        # Display the result and updated scores
        print(result)
        print(f"Score - User: {user_score}, Computer: {computer_score}")

        # Check if either user or computer has reached 3 points
        if user_score == 3 or computer_score == 3:
            game_running = False
    else:
        # Inform the user if their choice is invalid
        print("Invalid choice. Try again.")

# Display the final result after the game loop ends
if not game_running:
    print("\nFinal Score - User:", user_score, "Computer:", computer_score)
    if user_score > computer_score:
        print("Congratulations! You won.")
    elif computer_score > user_score:
        print("Computer won the game.")
    else:
        print("It's a draw!")
 
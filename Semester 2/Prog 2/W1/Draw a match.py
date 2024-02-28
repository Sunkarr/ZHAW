import random

def get_bot_choice(stack_size: int):
    diff_target = (stack_size - 1) % 4
    if diff_target == 0:
        result = 1
    else:
        result = diff_target
    return result

def who_starts():
    starter = random.randint(0, 1)
    if starter == 0:
        result = (starter, "\nYou start")
    elif starter == 1:
        result = (starter, "\nThe computer makes the first move")
    return result

def print_menu():
    print("These are the possible inputs:")
    print("1: Draw 1 match")
    print("2: Draw 2 matches")
    print("3: Draw 3 matches")
    print("9: Quit")

starting_number = random.randint(10, 20)
menu_choice = 0
quit_game = False

# Display menu at the beginning
print_menu()
input("Press Enter to start the game.")

# Determine who starts
starter_info = who_starts()
print(starter_info[1])

while not quit_game:
    print(f"\n{'='*8}O" * starting_number)
    print(f"| The stack has {starting_number} matches. |")

    if starter_info[0] == 0:  # Human's turn
        valid_choice = False
        while not valid_choice:
            menu_choice = int(input("Type in a number: "))
            if menu_choice in [1, 2, 3] and menu_choice <= starting_number:
                starting_number -= menu_choice
                valid_choice = True
            elif menu_choice == 9:
                quit_game = True
                valid_choice = True
            else:
                print("Invalid input. Please enter a valid choice (1, 2, 3) that does not exceed the number of matches left.")
    else:  # Computer's turn
        bot_choice = get_bot_choice(starting_number)
        print(f"The computer draws {bot_choice} matches.")
        starting_number -= bot_choice

    # Check if the game is over
    if starting_number <= 0:
        if starter_info[0] == 0:
            print("\nSorry, you lose. The computer wins.")
        else:
            print("\nCongratulations! You win!")
        quit_game = True
    else:
        starter_info = (1 - starter_info[0], starter_info[1])  # Switch turns

print("Game over.")

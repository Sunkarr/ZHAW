import random

print("Guess a number from 1-10 the PC has chosen")

random_number = int(random.uniform(1.0, 11.0))
number_of_trys = 1

user_guess = int(input("Your guess:"))

if random_number == user_guess:
    print("Congrats, you found the right number in your first try!")

while user_guess != random_number:
    number_of_trys += 1
    if random_number < user_guess:
        print("The computer chosen number is smaller")
        user_guess = int(input("Your new guess:"))
    else:
        print("The computer chosen number is higher")
        user_guess = int(input("Your new guess:"))

if random_number == user_guess:
    print("Congrats, you found the right number within", number_of_trys, "try's!")
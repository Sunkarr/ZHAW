"""
Prog 1
W13
3. Phone Book (selective: DS WI)
Author: Jonas Bratschi (bratsjon)
Date: 16.12.2023
"""

"""phone_book = {
    'Alice': '0791234567',
    'Bob': '0792345678',
    'Charlie': '0793456789',}"""


def print_numbers(numbers):
    for name, number in numbers.items():
        print(name, number)


def add_number(numbers, name, number):
    numbers[name] = number


def lookup_number(numbers, name):
    number = numbers[name]
    return number

def remove_number(numbers, name):
    del numbers[name]

def load_numbers(numbers, filename):
    ???

def save_numbers(numbers, filename):
    with open(filename, "w") as f:
        for name, number in numbers.items():
            f.write(name + "," + number + "\n")

def print_menu():
    print("1. Print Phone Numbers")
    print("2. Add a Phone Number")
    print("3. Remove a Phone Number")
    print("4. Lookup a Phone Number")
    print("5. Load numbers")
    print("6. Save numbers")
    print("7. Quit")
    print

phone_book = {}
menu_choice = 0
print_menu()
quit = False

while not quit:
    menu_choice = int(input("Type in a number (1-7): "))
    if menu_choice == 1:
        print_numbers(phone_book)
    elif menu_choice == 2:
        print("Add Name and Number")
        name = input("Name: ")
        phone = input("Number: ")
        add_number(phone_book, name, phone)
    elif menu_choice == 3:
        print("Remove Name and Number")
        name = input("Name: ")
        remove_number(phone_book, name)
    elif menu_choice == 4:
        print("Lookup Number")
        name = input("Name: ")
        print(lookup_number(phone_book, name))
    elif menu_choice == 5:
        filename = input("Filename to load: ")
        load_numbers(phone_book, filename)
    elif menu_choice == 6:
        filename = input("Filename to save: ")
        save_numbers(phone_book, filename)
    elif menu_choice == 7:
        quit = True
    else:
        print_menu()

"""
Prog 1
W13
3. Phone Book (selective: DS WI)
Author: Jonas Bratschi (bratsjon)
Date: 18.12.2023
"""

"""phone_book = {
    'Alice': '0791234567',
    'Bob': '0792345678',
    'Charlie': '0793456789',}"""


def print_numbers(numbers):
    """
    Print the names and corresponding phone numbers in the phone book.
    :param numbers: phonebook to print
    :return: printed values, each tuple on one line
    """
    for name, number in numbers.items():
        print(name, number)


def add_number(numbers, name, number):
    """
    Add a new tuple (name and phone number) to the phone book.
    Checks also if person already exists in phonebook.
    :param numbers: phonebook to add
    :param name: name of person
    :param number: phone number of person
    :return: updated phonebook with new tuple
    """
    if name not in numbers:
        numbers[name] = number
        print(f"Success: {name} has been added")
    else:
        print(f"Error: {name} already exists")


def lookup_number(numbers, name):
    """
    Lookup and return the phone number for a given name.
    Checks also if person exists in phonebook.
    :param numbers: phonebook to lookup
    :param name: name of person
    :return: number of person
    """
    try:
        number = numbers[name]
        return number
    except KeyError:
        print(f"Error: {name} is not in phonebook")
        return ""


def remove_number(numbers, name):
    """
    Remove a name and its corresponding phone number from the phone book.
    Checks also if person exists in phonebook.
    :param numbers: phonebook
    :param name: name you want to delete
    :return: updated phonebook without removed tuple
    """
    try:
        del numbers[name]
        print(f"Success: {name} has been removed")
    except KeyError:
        print(f"Error: {name} is not in phonebook")
        return ""

def load_numbers(numbers, filename):
    """
    Load phone numbers from a file and add them to the phone book.
    Checks also if file exists in folder.
    :param numbers: variable to store the imported tuples
    :param filename: filepath of file you want to import
    :return: updated variable numbers with new tuples
    """
    try:
        with open(filename, "r") as f:
            for line in f:
                name, number = line.strip().split(',')
                numbers[name] = number
        print(f"Success: File {filename} has been loaded")

    except:
        print(f"Error: File {filename} not fond")
        return ""

def save_numbers(numbers, filename):
    """
    Save phone numbers from the phone book to a file.
    Gives also feedback wether save function was successfull
    :param numbers: phonebook you want to store
    :param filename: filename to store the phonebook
    :return: no direct return,
    result of function is a generated file with all tuples of phonebook
    """
    with open(filename, "w") as f:
        for name, number in numbers.items():
            f.write(name + "," + number + "\n")
    print(f"Success: File {filename} has been saved")


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

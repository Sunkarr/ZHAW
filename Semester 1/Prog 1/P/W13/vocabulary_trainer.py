"""
Prog 1
W13
P07 – Dictionaries
1. Vocabulary Trainer (optional)
Author: Jonas Bratschi (bratsjon)
Date: 22.12.2023
"""

import random

"""filename = "dictionary.txt"
"""
voci = {}

def import_voci(voci, filename):
    with open(filename, "r") as f:
        for line in f:
            words = line.strip().split(' ')
            eng = words[0]
            deu = []
            for index in range(1, len(words)):
                deu.append(words[index])
            voci[eng] = deu
    print(f"Success: Words from {filename} have been added")

def extend_voci(voci):
    input_eng = input("Type the English word: ")
    input_deu = input("Type the German word (if there are multiple meanings, separate each word by comma): ")
    eng = input_eng
    deu = input_deu.strip().split(', ')
    voci[eng] = deu


def print_dictionary(voci):
    for eng, deu in voci.items():
        print(eng, ":", deu)

def learn_and_remove_voci(voci):
    try:
        random_key = random.choice(list(voci.keys()))
        random_eng_word = random_key
        input_deu = input(f"Type one translation of '{random_eng_word}' in german: ")
        if input_deu in voci[random_key]:
            print(f"Correct! The tuple '{random_eng_word}' and '{input_deu}' have been removed from your dictionary")
            del voci[random_key]
        else:
            print("Wrong, try again")
    except IndexError:
        print("There are no tuples in voci!")



def print_menu():
    print("1. Import a dictionary")
    print("2. Add tuples to dictionary")
    print("3. Print Voci")
    print("4. Learn Voci")
    print("9. Quit")
    print

menu_choice = 0
print_menu()
quit = False

while not quit:
    menu_choice = int(input("Type in a number (1-9): "))
    if menu_choice == 1:
        print("Import a dictionary")
        filename = input("Filename: ")
        import_voci(voci, filename)
    elif menu_choice == 2:
        print("Add tuples to dictionary")
        extend_voci(voci)
    elif menu_choice == 3:
        print_dictionary(voci)
    elif menu_choice == 4:
        learn_and_remove_voci(voci)
    elif menu_choice == 9:
        quit = True
    else:
        print_menu()















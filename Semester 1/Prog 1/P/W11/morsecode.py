import string

letters = list(string.ascii_uppercase)

morse_code_dict = {
    'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.',
    'F': '..-.', 'G': '--.', 'H': '....', 'I': '..', 'J': '.---',
    'K': '-.-', 'L': '.-..', 'M': '--', 'N': '-.', 'O': '---',
    'P': '.--.', 'Q': '--.-', 'R': '.-.', 'S': '...', 'T': '-',
    'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-', 'Y': '-.--',
    'Z': '--..'
}

while True:
    user_input = input("Type in a letter you want to know the Morse code (type 'quit' to exit): ")

    if user_input.upper() == 'QUIT':
        print("Programm ended")
        break

    if user_input.upper() not in letters:
        print("Wrong input, please type a letter")
    else:
        print("Morse code for the letter", user_input.upper(), "is", morse_code_dict[user_input.upper()])
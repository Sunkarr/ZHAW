"""
Prog 1
W05
(G4) P04 Functions - 1.2 Caesar Cipher
Author: Jonas Bratschi (bratsjon)
Date: 04.11.2023
"""


def decrypt(message: str, shift: int):
    decrypt_message = ''
    abcstart = ord("a")
    abcend = ord("z")
    abclength = abcend - abcstart + 1
    for char in message:
        # iterates throug every character
        if abcstart <= ord(char.lower()) <= abcend:
            # checks  if its a lower character, if yes then it gets transformed
            decrypted_value = ord(char.lower()) + shift
            if shift > 0:
                if abcend < decrypted_value <= abcend+shift:
                    # checks  if the end of the alphabet is reached in positive direction
                    decrypted_value -= abclength
                    decrypt_message += chr(decrypted_value)
                else:
                    decrypt_message += chr(decrypted_value)
            elif shift < 0:
                if abcstart > decrypted_value >= abcstart+shift:
                    # checks  if the end of the alphabet is reached in negative direction
                    decrypted_value += abclength
                    decrypt_message += chr(decrypted_value)
                else:
                    decrypt_message += chr(decrypted_value)
        else:
            decrypt_message += str(char)

    return decrypt_message


def findshift(message: str):
    for shift in range(-10, 10, 1):
        message = decrypt(text_input, shift)
        if "python" in message:
            return(shift)


text_input = input("Enter a text you want to decode:")
print("The message was shiftet by: ", (findshift(text_input)*-1))
print("The original message was: ", decrypt(text_input, findshift(text_input)))
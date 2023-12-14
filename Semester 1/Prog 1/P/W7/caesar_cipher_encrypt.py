"""
Prog 1
W05
P04, Aufgabe 1.2 Caesar cipher
Author: Jonas Bratschi (bratsjon)
Date: 04.11.2023
"""

def encrypt(message: str):
    shift = user_shift
    encrypt_message = ''
    for char in message:
    # iterates throug every character
        if 97 <= ord(char.lower()) <= 122:
        # checks  if its a lower character, if yes then it gets transformed
            encrypted_value = ord(char.lower()) + shift
            if shift > 0:
                if 122 < encrypted_value <= 122+shift:
                # checks  if the end of the alphabet is reached in positive direction
                    encrypted_value -= 26
                    encrypt_message += chr(encrypted_value)
                else:
                    encrypt_message += chr(encrypted_value)
            elif shift < 0:
                if 97 > encrypted_value >= 97+shift:
                # checks  if the end of the alphabet is reached in negative direction
                    encrypted_value += 26
                    encrypt_message += chr(encrypted_value)
                else:
                    encrypt_message += chr(encrypted_value)
        else:
            encrypt_message += str(char)

    return encrypt_message

# get user information
user_shift = int(input("Enter a positive or negative number for transformation:"))
user_input = input("Enter a text:")
# do whatever you want with the function response
print("\nYour encripted text:\n" + encrypt(user_input))

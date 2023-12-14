"""
Prog 1
W05
P04, Aufgabe 1.2 Caesar cipher
Author: Jonas Bratschi (bratsjon)
Date: 04.11.2023
"""

def encrypt(message: str):
    shift = +3
    encrypt_message = ''
    for char in message: # iterates throug every character
        if 97 <= ord(char.lower()) <= 122: # checks  if its a lower character, if yes then it gets transformed
            encrypted_value = ord(char.lower()) + shift
            if 122 < encrypted_value <= 122+shift: # checks  if the end of the alphabet is reached
                encrypted_value -= 26
                encrypt_message += chr(encrypted_value)
            else:
                encrypt_message += chr(encrypted_value)
        else:
            encrypt_message += str(char)

    return encrypt_message

# call the function
function_response1 = encrypt("brxu#46#phvvdjhv#wr#hqfubsw$")

# do whatever you want with the function response
print(function_response1)


def decrypt(message: str):
    shift = -3
    decrypt_message = ''
    for char in message:
        if 97 <= ord(char.lower()) <= 122:
            decrypted_value = ord(char.lower()) + shift
            if 97 > decrypted_value >= 97+shift:
                decrypted_value += 26
                decrypt_message += chr(decrypted_value)
            else:
                decrypt_message += chr(decrypted_value)
        else:
            decrypt_message += str(char)

    return decrypt_message

# call the function
function_response2 = decrypt("euax#46#skyygmky#zu#ktixevz$")

# do whatever you want with the function response
print(function_response2)
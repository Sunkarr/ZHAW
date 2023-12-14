"""
Prog 1
W05
P04, Aufgabe 1.2 Caesar cipher

Author: Jonas Bratschi (bratsjon)
Date: 04.11.2023
"""

def encrypt(message: str):
    shift = -2
    encrypt_message = ''
    for char in message:
        encrypted_value = ord(char.lower()) + shift
        if 122 < encrypted_value <= 122+shift:
            encrypted_value -= 26
        encrypt_message += chr(encrypted_value)

    return encrypt_message

def decrypt(message: str):
    shift = +2
    decrypt_message = ''
    for char in message:
        decrypted_value = ord(char.lower()) + shift
        if 97 > decrypted_value >= 97+shift:
            decrypted_value += 26
        decrypt_message += chr(decrypted_value)

    return decrypt_message
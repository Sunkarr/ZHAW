"""
SEP Prog 2
Author: Jonas Bratschi (bratsjon)
Disclaimer: Each of the tasks was created entirely or with the help of ChatGPT,
Google Gemini, Anthropic Claude or similar AI tools.
Date: 20.06.2024

Aufgabe 2: Passwortprüfung (10P)

- Aufgabenstellung siehe Blatt Teil 2
"""

import string

def is_valid_password(password):
    if len(password) < 7:
        return False

    if len(set(password)) != len(password):
        return False

    categories = {
        'lower': False,
        'upper': False,
        'digit': False,
        'special': False
    }

    for char in password:
        if char in string.ascii_lowercase:
            categories['lower'] = True
        elif char in string.ascii_uppercase:
            categories['upper'] = True
        elif char in string.digits:
            categories['digit'] = True
        elif char in string.punctuation + ' ':
            categories['special'] = True

    if sum(categories.values()) < 3:
        return False

    return True

if __name__ == "__main__":
    print(is_valid_password("Aa1!"))  # False, less than 7 characters
    print(is_valid_password("Aa1!Aa1!"))  # False, repeated characters
    print(is_valid_password("Aa1!b2@"))  # True, meets all criteria
    print(is_valid_password("abcdefg"))  # False, only one category
    print(is_valid_password("ABCDEFG"))  # False, only one category
    print(is_valid_password("1234567"))  # False, only one category
    print(is_valid_password("!@#$%^&"))  # False, only one category
    print(is_valid_password("A1b!c2D$"))

# some passwords that should match the requirements:
# ['A1b!c2D$', '9gH!5iK', 'L3m%4N*o', 'qR2s!5tU', 'V7w@X4yZ', 'a2B3c&D*', 'E!4F5gH^', 'i6J%K7lM', 'n@8oP#Q', 'R3sT$5uV']

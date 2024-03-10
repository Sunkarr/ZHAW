from datetime import datetime

def is_younger_than_25(birthdate_str):
    # Convert input string to datetime object
    birthdate = datetime.strptime(birthdate_str, "%Y-%m-%d")

    # Get the current date
    current_date = datetime.now()

    # Calculate the age
    age = current_date.year - birthdate.year - ((current_date.month, current_date.day) < (birthdate.month, birthdate.day))

    # Check if the age is less than 25
    return age < 25

birthdate_str = "2001-01-01"  # Corrected with quotes

print(is_younger_than_25(birthdate_str))

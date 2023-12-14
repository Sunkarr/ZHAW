from datetime import date

bday = date(1999, 1, 25)
today = date.today()

daysbetween = today - bday

print("Tage seit meinem Geburtstag:", daysbetween.days)
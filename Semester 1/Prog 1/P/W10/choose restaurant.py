import random

r_filename = "./restaurants.txt"
r = []

with open(r_filename, 'r') as f:
    for line in f:
        r.append(line.strip())

random_number = random.randint(0, len(r))

print("Your favorite restaurant is: ", r[random_number])


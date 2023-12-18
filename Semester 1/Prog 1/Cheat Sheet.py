# Read file
with open(filename, "r") as f:
    for line in f:
        name, number = line.strip().split(',')
        numbers[name] = number

# Print file
with open(filename, "w") as f:
    for name, number in numbers.items():
        f.write(name + "," + number + "\n")
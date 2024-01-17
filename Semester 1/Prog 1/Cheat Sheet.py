# Read file
with open(filename, "r") as f:
    for line in f:
        name, number = line.strip().split(',')
        numbers[name] = number


# Print file
with open(filename, "w") as f:
    for name, number in numbers.items():
        f.write(name + "," + number + "\n")


my_dict = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'}
# Delete the item with key 'key2'
del my_dict['key2']
# Print the updated dictionary
print(my_dict)


# Iterate with nested loop through sub-list

fruits = [["apple", "orange"], ["carrot", "cabbage"]]

for groups in fruits:
    for element in groups:
        print(element)


# Find index of max value in list

temperaturen = [25, 21, 22, 27, 29, 23, 29]

def optimaler_badetag(temperaturen):
    wochentage = ["MO", "DI", "MI", "DO", "FR", "SA", "SO"]
    maxtempindex = temperaturen.index(max(temperaturen))
    badetag = wochentage[maxtempindex]
    return badetag

print(optimaler_badetag(temperaturen))


# Writes all digits from 1 to 99 to the console, cuts off the last comma

numbers = ""
for index in range(1, 100):
    numbers += str(index) + ","
print(numbers[0:-1])



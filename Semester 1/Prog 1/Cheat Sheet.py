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

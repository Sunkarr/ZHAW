import random

"""list_lentgth = random.randint(1, 101)

list = []

for element in range(list_lentgth):
    list.append(random.randint(1, 101))

print(list)"""

list = [66, 97, 20, 79, 91, 41, 53, 82, 44, 99, 33, 75, 31, 51, 45, 63, 58, 101, 86, 63, 72, 15, 82, 8, 34, 27, 99, 62, 81, 79, 76, 30, 30, 40, 5, 27, 55, 69, 89, 50, 57, 43, 24, 81, 42, 33, 23, 79, 21, 37, 37, 88, 82, 57, 60, 33, 66, 31, 5, 76, 24, 98, 30, 31, 40, 19, 37, 82, 52, 48, 18, 3, 76, 85, 3, 30, 30, 39, 55, 78, 68, 44, 53, 53, 82, 22, 29, 53]

def get_durchschnitt(list):
    summe = 0
    for number in list:
        summe += number
    durchschnitt = summe / len(list)
    return durchschnitt

def get_nearest_index(list):
    average = get_durchschnitt(list)
    mindiff = len(list)
    minindex = 0
    minzahl = 0
    for index in range(len(list)):
        diff = abs(list[index] - average)
        if diff < mindiff:
            mindiff = diff
            minindex = index
            minzahl = list[index]
    result = [minindex, minzahl, average]
    return result

print(get_nearest_index(list))




import random

board = [
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0]
]

x = random.randint(0, 7)
y = random.randint(0, 7)

board [y] [x] = 1

possible_x_and_y_values = [[2, 1],
                           [1, 2],
                           [-2, -1],
                           [-1, -2],
                           [2, -1],
                           [1, -2],
                           [-2, 1],
                           [-1, 2]]

for move in possible_x_and_y_values:
    new_x = x + move[0]
    new_y = y + move[1]
    if 0 <= new_x <= 7 and 0 <= new_y <= 7:
        board[new_y][new_x] = 2

for row in board:
    for cell in row:
        if cell == 0:
            print(".", end=" ")
        elif cell == 1:
            print("*", end=" ")
        elif cell == 2:
            print("#", end=" ")
    print()

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

random_row = int(random.uniform(0.0, 8.0))
random_column = int(random.uniform(0.0, 8.0))

board[random_row][random_column] = 1

print("x=", random_column + 1, "y= -", end="")
print(random_row + 1)

for row in board:
    for cell in row:
        if cell == 0:
            print(".", end=" ")
        elif cell == 1:
            print("*", end=" ")
    print()

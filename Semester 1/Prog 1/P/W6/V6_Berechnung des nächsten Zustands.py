board = [
    [0, 1, 0],
    [1, 0, 0],
    [1, 0, 0]
]

for row in board:
    for cell in row:
        if cell == 0:
            print(".", end=" ")
        elif cell == 1:
            print("#", end=" ")
    print()

print("\n")

board_new = [
    [0, 0, 0],
    [1, 1, 0],
    [0, 0, 0]
]

for row in board_new:
    for cell in row:
        if cell == 0:
            print(".", end=" ")
        elif cell == 1:
            print("#", end=" ")
    print()

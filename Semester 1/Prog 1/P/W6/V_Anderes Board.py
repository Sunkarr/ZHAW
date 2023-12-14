import random

board = \
    [[0, 0, 0, 0, 0,],
     [0, 0, 0, 1, 0,],
     [0, 0, 1, 1, 0,],
     [0, 0, 1, 0, 0,],
     [0, 0, 0, 0, 0,]]

new_board = \
    [[0, 0, 0, 0, 0,],
     [0, 0, 0, 0, 0,],
     [0, 0, 0, 0, 0,],
     [0, 0, 0, 0, 0,],
     [0, 0, 0, 0, 0,]]

"""for i in range(12):
    x = random.randint(1, 3)
    y = random.randint(1, 3)

    board[y][x] = 1"""

for i in range(1, len(board) - 1):
    inner = board[i]
    for j in range(1, len(inner) - 1):
        e = inner[j]
        if e == 0:
            print(" . ", end="")
        elif e == 1:
            print(" # ", end="")

    print()

for i in range(1, len(board) - 1):
    inner = board[i]
    for j in range(1, len(inner) - 1):
        e = inner[j]
        num_living_neighbours = board[i - 1][j - 1] + board[i - 1][j] + board[i - 1][j + 1] + \
                                board[i][j - 1] + + board[i][j + 1] + \
                                board[i + 1][j - 1] + board[i + 1][j] + board[i + 1][j + 1]

        if e == 1 and num_living_neighbours == 2 or num_living_neighbours == 3:
            new_board[i][j] = 1
        if e == 0 and num_living_neighbours == 3:
            new_board[i][j] = 1

print()

for i in range(1, len(new_board) - 1):
    inner = new_board[i]
    for j in range(1, len(inner) - 1):
        e = inner[j]
        if e == 0:
            print(" . ", end="")
        elif e == 1:
            print(" # ", end="")

    print()
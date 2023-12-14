"""
Prog 1
W11
G6:Battleship–Log File
Author: Jonas Bratschi (bratsjon)
Date: 30.11.2023
"""

import random

def random_point_in_board(x, y):
    return random.randint(0, x - 1), random.randint(0, y - 1)

def print_plain_board(x, y):
    colum = ["O"] * x
    board = [list(colum) for _ in range(y)]
    for inner_list in board:
        print(' '.join(map(str, inner_list)))


def print_board_with_random_ship(x, y):
    colum = ["O"] * x
    board = [list(colum) for _ in range(y)]
    random_coordinates = random_point_in_board(x,y)
    print(random_coordinates)
    board[random_coordinates[1] - 1][random_coordinates[0] - 1] = "X"
    for inner_list in board:
        print(' '.join(map(str, inner_list)))


board_size_x = 15
board_size_y = 10

print_plain_board(board_size_x, board_size_y)
print_board_with_random_ship(board_size_x, board_size_y)


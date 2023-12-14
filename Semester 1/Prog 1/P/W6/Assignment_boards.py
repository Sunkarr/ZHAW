rows = 10
cols = 10


for col in range(cols):
    for row in range(rows):
        if 1 <= col < 9 and 1 <= row < 9:
            print("x", end=" ")
        else:
            print(".", end=" ")

    print()

print()

for col in range(cols):
    for row in range(rows):
        if col == row :
            print("x", end=" ")
        elif col+row == 9:
            print("x", end=" ")
        else:
            print(".", end=" ")
    print()
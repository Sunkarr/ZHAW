rows = 15
cols = 15

for i in range(rows):
    for j in range(cols):
        if j >= cols - i - 1:
            print("x", end=" ")
        else:
            print(".", end=" ")
    print()

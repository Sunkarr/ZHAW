numb = int(input("Type in a Number, which you want to count down:"))
print("for loop:")
for x in range(numb, -1, -1):
    print(x)

print("while loop:")
while numb >= 0:
    print(numb)
    numb -= 1
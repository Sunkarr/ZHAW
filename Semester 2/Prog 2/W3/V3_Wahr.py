index = 0
p = 1

while p > 0.5:
    p *= (365 - index) / 365
    index += 1

print(index)

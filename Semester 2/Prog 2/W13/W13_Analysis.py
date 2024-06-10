def funktion(x, y):
    return (x-1)/y

# Anfangswerte und Schrittweite
y_start = 5
x_start = 0
x_ziel = 10
h = 1  # Schrittweite
n = int((x_ziel - x_start) / h)  # Anzahl der Schritte

# Initialwerte
x = x_start
y = y_start

print(f"Step 0: x = {x:.3f}, y = {y:.3f}")

# Eulerverfahren Schleife
for i in range(n):
    y = y + h * funktion(x, y)
    x = x + h
    print(f"Step {i + 1}: x = {x:.3f}, y = {y:.3f}")

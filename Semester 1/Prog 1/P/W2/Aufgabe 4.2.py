#Aufgabe 4.2

v0=float(input("Geschwindigkei eingeben [km/h]:"))
mu=0.3
g=9.81

v0m=v0/3.6
d=(0.5*(v0m**2))/(mu*g)

print("Bremsweg in m:", d)




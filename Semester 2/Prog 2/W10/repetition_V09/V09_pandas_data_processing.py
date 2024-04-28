import pandas as pd

points = pd.DataFrame({"Points": [80, 93, 78, 85, 97, 75, 88, 91]}, 
         index=['LA2','PM2','PROG2','AN2','PHYS2', 'BWP2', 'COM2', 'WAHR'])

print("\n1 Ausgabe")
print("The Points obtained by student are", points, sep='\n')

print("\n2 Filtern")
print(points['Points']['PROG2'])
print(points.Points.PROG2)

print("\n3 Durchschnitt")
print(points['Points'].mean())
print(points.Points.mean())

print("\n4 Runden")
print(round(points.Points.mean()))
print(int(points.Points.mean()))
print('{:.0f}'.format(points.Points.mean()))

print("\n5 Sortieren")
print(points.Points.nlargest(n = 3))
print(points.Points.sort_values(ascending = False)[:3])
print(points.Points.sort_index())

print("\n6 Funktionen")
grade = lambda x : x * 5 / 100 + 1
print(round(points.Points.apply(grade).mean(), 1))

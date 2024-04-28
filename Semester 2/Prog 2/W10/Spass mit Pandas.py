import pandas as pd

points = pd.DataFrame({"Points": [80, 93, 78, 85, 97, 75, 88, 91]},
                      index=['LA2', 'PM2', 'PROG2', 'AN2', 'PHYS2', 'BWP2', 'COM2', 'WAHR'])

# print(points.at['PROG2', 'Points'])
# print(points['Points'])

# print(points['Points'].mean())

"""mean = points['Points'].mean()
print(f"Mean: {mean:2.1f}")"""

"""sorted_points = points.sort_values(by="Points", ascending=False)
print(sorted_points.head(3))"""


"""def grade(punkte):
    note = (punkte*5 / 100) + 1
    return f"{note:.2f}"

points['Note'] = points['Points'].apply(grade)
print(points.sort_values(by='Points', ascending=False))"""

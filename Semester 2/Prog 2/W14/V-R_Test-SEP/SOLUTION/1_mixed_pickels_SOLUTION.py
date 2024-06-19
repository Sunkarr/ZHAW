# -*- coding: utf-8 -*-
"""
Created on Sat May 14 14:09:44 2022

@author: rots
"""

print("\n1) Mixed Pickles")

# 1)

# 2)
print(f"\n1.2) 'Winterthur' > 'New York' = {'Winterthur' > 'New York'}")
print(f"   ZUSATZ: ord('A') = {ord('A')}, chr(65) = {chr(65)}")

# 3)
print("\n1.3) def init(name) <== 'self' fehlt")

# 4)
print('\n1.4) json.loads(s)["alter"] <== print() fehlt')
import json
s = '{"alter": 99, "gewicht": 41}'
print("   ZUSATZ: Ausgabe wäre", json.loads(s)["alter"])

# 7)
print("\n1.7) open('video.mpg', mode='rb') <== öffnet nur, liest nicht, f.read() fehlt")
f = open('video.mp4', mode='rb')
content = f.read(1048)
print("   ZUSATZ: Content-Info: ", type(content), ":", len(content))

# 9)
def konvergenz(a):
    return a / (2 * a - a * a)
print("\n1.9) Konvergenzfunktion")
print(f"konvergenz(4) = {konvergenz(4)}")
print("konvergenz(0) = ERROR: division by zero")

# 10)
print("\n1.10) Internetverbindung")
print("False, da auch abhängig von vielen anderen Grössen (z.B. Zwischenstationen)\n")

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Dec 30 09:59:45 2022

@author: bodr

Modified on 2023.01.25, delo
"""

import math
import numpy as np
from matplotlib import pyplot as plt

def printShort5(x):
    print( np.format_float_scientific( x, precision = 4 ))

'''
Aufgabe 1
'''

# Funktion x * np.cos(2*x)
xs = np.linspace( math.pi - 0.5, math.pi + 0.5, 1000 )
y = xs * np.cos( 2*xs )

# Koeffizienten Taylor Polynom an Stelle x0
x0 = math.pi; # Entwicklungspunkt
f = x0*np.cos( 2*x0 ) 
a0 = f
fstrich = np.cos(2*x0) - 2*x0*np.sin(2*x0)
a1 = fstrich/math.factorial(1)
f2strich = -4*np.sin(2*x0) - 4*x0*np.cos(2*x0)
a2 = f2strich/math.factorial(2)
f3strich = -12*np.cos(2*x0) + 8*x0*np.sin(2*x0)
a3 = f3strich/math.factorial(3)

# Visualisierung der Originalfunktion und der Taylorpolynome
t3plot = f + fstrich*(xs-x0) + f2strich/2 *(xs-x0)**2 + f3strich/6*(xs-x0)**3
plt.plot( xs, y, xs, t3plot )
plt.legend(['x cos(2x)','t3']);

# Auswertung aller Taylorpolynome an der Stelle x1
x1 = math.pi+0.1  # Auswertungspunkt
plt.plot( x0, x0*np.cos(2*x0), marker='.' )
plt.plot( x1, x1*np.cos(2*x1), marker='*' ) # Vergleichsplot

t3_x1 = f + fstrich*(x1-x0) + f2strich/2 *(x1-x0)**2 + f3strich/6*(x1-x0)**3
exakt = x1*np.cos(2*x1)
#%%
# Fehler (Betrag der Abweichung von ) der Taylorpolynome an der Stelle x1
fehler3 = abs(exakt-t3_x1)
printShort5( fehler3 )

#%%
'''
Aufgabe 2
'''

print( pow( 7, 1/3 ))

#%%
'''
Aufgabe 3
'''

# Teil b)
printShort5( np.sinh(1))
printShort5( np.cosh(1))

# Teil c)
def f(x):
 return np.log(x) * np.cosh(x)

def t2(x):
    return 0 + np.cosh(1)*(x - 1) - (np.cosh(1)/2 - np.sinh(1)) * (x - 1)**2

x1 = 1.5
x2 = 2

err1 = abs(f(x1)-t2(x1))
err2 = abs(f(x2)-t2(x2))

printShort5( err1 )
printShort5( err2 )

#%%
'''
Aufgabe 4
'''

def f(x):
    return x**2 - np.cos(2*x)

# Teil a)
xs = np.linspace( -3, 3, 1000 )
ys = f(xs)
zero = [0]*len(xs)
plt.plot( xs, ys, xs, zero )
plt.show()
#%%
# ergibt Intervalle
a1, b1 = -0.8, -0.4
a2, b2 = 0.4, 0.8

a, b = a1, b1

if f(a)*f(b) < 0:
    tol = 1.e-10
    k = 0 
    left = a
    right = b
    while abs(right-left) > tol:
        mid = (left+right)/2
        fmid = f(mid)
        k = k+1
        if fmid*f(right) < 0:
            left = mid
        else: 
            right = mid
else:
    print('Bisektion unmoeglich')
    
print( k, left, right )


#%%
'''
Aufgabe 5
'''

def f(x):
    return x**2 * np.log(x**3) - 2

# Teil a)
a, b = 1, 2
print( 'f(', a, ') =', f(a), ', f(', b, ') =', f(b))


# Teil d)
def fstrich(x):
    return 3 * x + 2 * x * np.log(x**3)

k = 0
xk = x0

# Newton
while k < 4:
    x0 = x0 - f(x0) / fstrich(x0) # Newtonschritt
    k = k + 1
    xk = x0

x4 = np.format_float_scientific( xk, precision = 4 ) 
f4 = np.format_float_scientific( f(xk), precision = 4 ) 
print('x =', x4, 'in', k, 'Schritten, f(x) =', f4 )


#%%
'''
Aufgabe 6
'''

# Teil b)

def F(x):
    return np.log(x) * np.cosh(x) + 4*(x-1.5)**2 - 3

a = 0.2
print( 'F(', a, ') =', F(a))
a = 1
print( 'F(', a, ') =', F(a))
a = 2
print( 'F(', a, ') =', F(a))

#%%
# Teil c)

nschritte = 4
a, b = 0.2, 1

for i in range( nschritte ):
    m = (a+b) / 2
    if F(a) * F(m) < 0:
        b = m
    else: 
        a = m
        

printShort5( a )
printShort5( b )

#%%
# Teil d)

def Fstrich(x):
    return 8*x + np.cosh(x)/x + np.log(x)*np.sinh(x) - 12

k = 0
xk = 1.5

# Newton
while k < 4:
    xk = xk - F(xk) / Fstrich(xk) # Newtonschritt
    k = k + 1

x4 = np.format_float_scientific( xk, precision = 4 ) 
F4 = np.format_float_scientific( F(xk), precision = 4 ) 
print('x =', x4, 'in', k, 'Schritten, F(x) =', F4 )

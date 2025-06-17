#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan  2 10:38:25 2023

@author: bodr

Modified on 2023.01.25, delo
"""

import math
import numpy as np
from matplotlib import pyplot as plt
from scipy import integrate

def printShort5(x):
    print( np.format_float_scientific( x, precision = 4 ))

'''
Aufgabe 2
'''
#x=[-4, -2, 2, 4]; y=[48, 12, 12, 48]
#x=[1, 2, 4, 8]; y=[1, 3, 7, 15]
#x=[-1, 0, 1, 2]; y=[0, 1, 2, 9]
x=[1, 2, 4, 8]; y=[0, 2, 12, 56]

p1=lambda x: x+1; p2=lambda x: 2*x-1; p3=lambda x: 3*x**2; p4=lambda x: x**2 - x
p5=lambda x: x*3+1;
xx=np.arange(x[0]-0.5, x[-1]+0.51,0.01)
yy1=p1(xx); yy2=p2(xx); yy3=p3(xx); yy4=p4(xx); yy5=p5(xx)
plt.plot(x,y,'x ',xx,yy1,xx,yy2,xx,yy3,xx,yy4,xx,yy5, linewidth=2)
plt.legend(('xy','p1','p2','p3','p4','p5'))

#%%
'''
Aufgabe 3
'''

xi = np.array( [-1, 1, 3, 4] )
yi = np.array( [-1, 0, 2, 5] )
V = np.array( [np.ones(4), xi ] ).T

# Teil a)
# Normalengleichung
A = V.T @ V
b = V.T @ yi
p = np.linalg.solve( A, b )
print( 'A = ' )
print( A ) 
print( 'b = ' )
print( b ) 
print()
#%%
# Teil b)
print( 'Lösung:' )
printShort5( p[0] )
printShort5( p[1] )

# Plot der Lösung
plt.figure(0)
xx = np.linspace( xi[0]-0.5, xi[-1]+0.5, 100 )
yy = p[0] + p[1]*xx # Modell
plt.plot( xi, yi, 'bx ', xx, yy, 'r-' )

# Teil c)
V = np.array( [np.ones(4), np.exp(xi) ] ).T
# Normalengleichung
A = V.T @ V 
b = V.T @ yi
p = np.linalg.solve( A, b )
print( 'A = ' )
print( A ) 
print( 'b = ' )
print( b ) 
print()
print( 'Lösung:' )
printShort5( p[0] )
printShort5( p[1] )

# Plot der Lösung$
plt.figure(1)
xx = np.linspace( xi[0]-0.5, xi[-1]+0.5, 100 )
yy = p[0] + p[1]*np.exp(xx) # Modell
plt.plot( xi, yi, 'bx ', xx, yy, 'r-' )


#%%
'''
Aufgabe 5
'''

def f( t, z ): 
    return np.array( [z[1], z[0] + 2*z[3] - z[0]/(z[0]**2+z[2]**2)**(3/2),
                      z[3], z[2] - 2*z[1] - z[2]/(z[0]**2+z[2]**2)**(3/2)] )


z0 =  np.array( [ 1, 3, 2, 4] ) # Anfangsbedingungen für z1=u, z2=u', z3=v, z4=v'
#z0=[1; 2; 3; 4]; %anfangsbed fuer z1=u, z2=v,  z3=u',z4=v'
I = [0,10] # Zeitfenster
t_eval = np.linspace( 0, 10, 100 )

result = integrate.solve_ivp(f, I, z0, t_eval = t_eval)
t = result['t']
z = result['y']

plt.figure(2)
plt.plot( t, z[0,:], t, z[2,:] ) 
plt.legend(['u','v','Location','NorthWest'])
plt.xlabel('t')
plt.ylabel('u, v')

print( 'u(10) = ' )
printShort5( z[0,-1] )
print( 'v(10) = ' )
printShort5( z[2,-1] )

#%%
'''
Aufgabe 6
'''

def einsetzen( R, b ):
    n = len(b)
    x = np.zeros(n)
    
    for i in range( n, 0, -1 ):
        for j in range( i+1, n+1 ):
            b[n-i] = b[n-i] - R[n-i,j-1]*x[j-1]
        x[i-1] = b[n-i]/R[n-i,i-1]
        
    return x


R = np.array( [[0, 0, 0, 9], [0, 0, 7, 8], [0, 4, 5, 6], [3, 2, 1, 0]] )
b = np.array( [1.0, 2.0, 3.0, 4.0] )
x = einsetzen( R, b )

print( 'Lösung:' )
for i in range( len(x) ):
    printShort5( x[i] )

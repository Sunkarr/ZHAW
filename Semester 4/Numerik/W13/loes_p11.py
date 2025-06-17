import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp

# =========
# P 11
# =========

#%% Aufg. 2

# AWP
f = lambda t, y : y/t-t**2/2
y0 = 4
t0 = 2

# Euler: y1 = y0 + h*f(t0, y0) mit h = 1
h = 1
y1 = y0 + h*f(t0,y0) # = 4 + 4/2-2^2/2 = 4
t1 = t0 + h          # = 3

y2 = y1 + h*f(t1,y1) # = 4 + 4/3-3^2/2 = 0.833
t2 = t1 + h          # = 4

y3 = y2 + h*f(t2,y2) # = 0.833 + 0.833/4-4^2/2 = -6.958
t3 = t2 + h          # = 5

print("t1=",t1, "y1=",y1)
print("t2=",t2, "y2=",y2)
print("t3=",t3, "y1=",y3)

# Fehler
y_ex = lambda t : 3*t-t**3/4
print("t0=",t0, "err=", abs(y0-y_ex(t0)))
print("t1=",t1, "err=", abs(y1-y_ex(t1)))
print("t2=",t2, "err=", abs(y2-y_ex(t2)))
print("t3=",t3, "err=", abs(y3-y_ex(t3)))


#%% Aufg. 3

f = lambda t, n: -0.5*n**1.5 + 400*(1-np.exp(-2*t))

# AB
n0 = 100;

# a)
# Loesung berechnen
tf = 3

# Euler
h = 0.02
steps = int(tf / h)
te = np.linspace(0, tf, steps + 1)
ne = np.zeros_like(te)
ne[0] = n0
for k in range(steps):
    ne[k+1] = ne[k] + h*f(te[k], ne[k])

# b)
sol = solve_ivp(f, t_span=(0, tf), y0=[n0], method='RK45', rtol=1e-6)
t = sol.t
n = sol.y

plt.figure()

plt.plot(te, ne, ':', label='Euler')
plt.plot(t, n[0,:], label='RK45')
plt.xlabel('t')
plt.ylabel('n')
plt.legend()


#%% Aufg. 4
"""
xdot = x - y*t = f_x(t,x,y),  x(0) = 1
ydot = t + y   = f_y(t,x,y),  y(0) = 1

z = (x,y)^T

t0 = 0
z0 = (x0,x0)^T = (1,1)^T

1. Schritt

x1 = x0 + h*f_x(t0,x0,y0) = 1 + 0.4*(1-1*0) = 1.4
y1 = y0 + h*f_y(t0,x0,y0) = 1 + 0.4*(1+0)   = 1.4
t1 = t0 + h = 0.4

2. Schritt

x2 = x1 + h*f_x(t1,x1,y1) = 1.4 + 0.4*(1.4-1.4*0.4) = 1.736
y2 = y1 + h*f_y(t1,x1,y1) = 1.4 + 0.4*(1.4+0.4)     = 2.12
t2 = t1 + h = 0.8

3. Schritt

x3 = x2 + h*f_x(t2,x2,y2) = 1.736 + 0.4*(1.736-2.12*0.8) = 1.752
y3 = y2 + h*f_y(t2,x2,y2) = 2.12 + 0.4*(2.12+0.8)        = 3.288
t3 = t2 + h = 0.4

...oder vektoriell
z_dot = f(t,z), f(t,z) = (z_0 - z_1*t, t+z_1)^T
"""
h = 0.4
f = lambda t, z : np.array([z[0] - z[1]*t, t+z[1]])
t0 = 0
z0 = np.array([1,1.])

z1 = z0 + h*f(t0,z0)
t1 = t0 + h
print("t=",t1, "z=",z1)

z2 = z1 + h*f(t1,z1)
t2 = t1 + h
print("t=",t2, "z=",z2)

z3 = z2 + h*f(t2,z2)
t3 = t2 + h
print("t=",t3, "z=",z3)


#%% Aufg. 5
"""
xdot2 = -xdot*(xdot^2+ydot^2)**0.5
ydot2 = -ydot*(xdot^2+ydot^2)**0.5 - 10

z1 = x
z2 = y
z3 = xdot
z4 = ydot

z1dot = z3
z2dot = z4
z3dot = -z3*(z3^2+z4^2)**0.5
z4dot = -z4*(z3^2+z4^2)**0.5 - 10

z(0) = (0,0,10,100)^T
"""

#%% Aufg. 6
"""
z = (x, xdot)^T

z_dot = ( z_1, -100*z_0 -0.1*z_1/|z_1| )^T, z(0) = (0.1, 0)^T
"""


f = lambda t, z : np.array([z[1], -100*z[0]-0.1*np.sign(z[1])])
z0 = np.array([0.1, 0])
tf = 10
sol = solve_ivp(f, t_span=(0, tf), y0=z0, method='RK23', rtol=1e-6)
t = sol.t
x = sol.y

plt.figure()
plt.plot(t, x[0,:])
plt.xlabel('t (s)')
plt.ylabel('x')


#%% Aufg. 7

# Erstellen der ODE
m = 80;
cL = 0.2;
g = 9.81;
f = lambda t,y: np.array([y[1], cL/m*y[1]**2-g])

y0 = np.array([3000.0, 0.0]);

# Loesung berechnen
tf = 60
sol = solve_ivp(f, t_span=(0, tf), y0=y0, method='RK45', rtol=1e-6)
t = sol.t
y = sol.y

plt.figure()
plt.plot(t, y[0,:], '-', t, t*0, ':k')
plt.xlabel('t (s)')
plt.ylabel('Hoehe (m)')

# Dauer des Sprungs aus Plot ablesen: ca. 52.32 s


#%% Aufg. 8

f = lambda t, z : np.array([ z[2],
                             z[3],
                             -z[2]*(z[2]**2+z[3]**2)**0.5,
                             -z[3]*(z[2]**2+z[3]**2)**0.5 - 10])
z0 = np.array([0, 0, 10, 100])

# Bahn berechnen
tf = 2
sol = solve_ivp(f, t_span=(0, tf), y0=z0, method='RK45', rtol=1e-6)
t = sol.t
z = sol.y

plt.figure()
plt.plot(z[0,:], z[1,:])
plt.xlabel('x')
plt.ylabel('y')

plt.show()

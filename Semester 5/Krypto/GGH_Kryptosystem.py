# -*- coding: utf-8 -*-
"""
Created on Thu Nov 28 17:16:24 2024

@author: beer
"""

import numpy as np


""" Private part """

PUBLIC_BASIS = np.array([[ 6,  4],
                         [21, 15]])
    
PRIVATE_BASIS = np.array([[2, 0],
                          [0, 3]])

VEC_SHAPE = (PUBLIC_BASIS.shape[0], 1)  # Spaltenvektoren!!!


def decrypt(c):
    
    print('')
    print('decrypt() invoked...')
    
    x = np.linalg.solve(PRIVATE_BASIS, c)
    #print(x)
    
    x = (np.rint(x)).astype(np.int64)    # auf naechste ganze Zahlen runden
    #print(x)
    
    c_error_free = PRIVATE_BASIS @ x
    #print(c_error_free)
    
    m = np.linalg.solve(PUBLIC_BASIS, c_error_free)
    #print(m)
    m = (np.rint(m)).astype(np.int64)    # auf int64 casten
    print(m)

    return m


def get_random_err():

    epsilon = 1e-12                      # wird fuer "offenes" Intervall gebraucht
    
    err = np.zeros(VEC_SHAPE, dtype=np.int64)
    
    for k in range(len(PRIVATE_BASIS)):
        rand_err = (np.random.random(1) - .5) * (1 - epsilon)
        err = err + (rand_err * PRIVATE_BASIS[:, k]).reshape(VEC_SHAPE)
        
    return err


def get_public_basis():
    return PUBLIC_BASIS



""" Key generation part """

def generate_random_basis(n):
        
    print('')
    print('generate_random_basis() invoked...')

    new_private_basis = np.random.randint(1, 10, (n, n))
    #print(new_private_basis)
    
    diag = np.random.randint(n*2*10, n*100, n)
    #print(diag)
    
    new_private_basis = new_private_basis + np.diag(diag)
    #print(new_private_basis)

    [U, Ui] = generate_random_unimodular_change_of_basis(n)
    new_public_basis = new_private_basis @ U
    
    set_new_public_basis(new_public_basis)
    set_new_private_basis(new_private_basis)


def generate_random_unimodular_change_of_basis(n):

    print('')
    print('generate_random_unimodular_change_of_basis() invoked...')

    change_of_basis = np.random.randint(10, 20, (n, n))
    #print(change_of_basis)

    diag = np.ones(n, dtype=np.int64)
    #print(diag)
    
    change_of_basis = np.triu(change_of_basis, 1) + np.diag(diag)
    #print(change_of_basis)
    
    for k in range(20):                 
        # exchange a random pair of rows i, j.
        row_i = np.random.randint(0, n)
        row_j = np.random.randint(0, n)
        while row_j == row_i:
            row_j = np.random.randint(0, n)
        change_of_basis[[row_i, row_j], :] = change_of_basis[[row_j, row_i], :]
        
        # add a random row i to a random row j, with i != j.
        row_i = np.random.randint(0, n)
        row_j = np.random.randint(0, n)
        while row_j == row_i:
            row_j = np.random.randint(0, n)
        change_of_basis[row_j, :] = change_of_basis[row_j, :] + change_of_basis[row_i, :]
        
        # exchange a random pair of colums i, j.
        row_i = np.random.randint(0, n)
        row_j = np.random.randint(0, n)
        while row_j == row_i:
            row_j = np.random.randint(0, n)
        change_of_basis[:, [row_i, row_j]] = change_of_basis[:, [row_j, row_i]]
        
        # add a random column i to a random column j, with i != j.
        row_i = np.random.randint(0, n)
        row_j = np.random.randint(0, n)
        while row_j == row_i:
            row_j = np.random.randint(0, n)
        change_of_basis[:, row_j] = change_of_basis[:, row_j] + change_of_basis[:, row_i]
        
    #print(change_of_basis)

    inv_change_of_basis = np.linalg.inv(change_of_basis)
    #print(inv_change_of_basis)

    inv_change_of_basis = np.rint(inv_change_of_basis).astype(np.int64) 
    #print(inv_change_of_basis)
    print(change_of_basis @ inv_change_of_basis)    # Pruefe, ob Einheitsmatrix
    
    return [change_of_basis, inv_change_of_basis]



def set_new_public_basis(new_public_basis):
        
    print('')
    print('set_new_public_basis() invoked...')
    
    global PUBLIC_BASIS
    global VEC_SHAPE
    PUBLIC_BASIS = new_public_basis
    print(PUBLIC_BASIS)
    VEC_SHAPE = (PUBLIC_BASIS.shape[0], 1)  # Spaltenvektoren!!!


def set_new_private_basis(new_private_basis):
        
    print('')
    print('set_new_private_basis() invoked...')
    
    global PRIVATE_BASIS
    global VEC_SHAPE
    PRIVATE_BASIS = new_private_basis
    print(PRIVATE_BASIS)
    VEC_SHAPE = (PRIVATE_BASIS.shape[0], 1) # Spaltenvektoren!!!



""" Public part """

def encrypt(m):
        
    print('')
    print('encrypt() invoked...')
    
    public_basis = get_public_basis()
    e = get_random_err()

    c = public_basis @ m
    #print(c)
    
    err = get_random_err()
    #print(err)
    
    c = c + err
    #print(c)
    
    return c



""" Eavesdropper part """

def try_decrypt_with_public_basis(c):
        
    print('')
    print('try_decrypt_with_public_key() invoked...')
   
    public_basis = get_public_basis()

    m = np.linalg.solve(public_basis, c)
    #print(m)
    
    m = (np.rint(m)).astype(np.int64)    # auf naechste ganze Zahlen runden
    print(m)
    return m



""" Test run """
if __name__ == '__main__':

    
    """ Aufgabe b) """

    print('')
    print('Aufgabe b)')    
    m = np.array([[4530], [2199]])          # Klartext
    c = encrypt(m)
    mm = decrypt(c)                         # sollte wieder m geben!
    mn = try_decrypt_with_public_basis(c)   # sollte in der Regel nicht m geben!

    
    
    """ Aufgabe c) """
    
    print('')
    print('Aufgabe c)')

    n = 6
    generate_random_basis(n)
   
    m = np.array([[4301], [2856], [7693], [3916], [8291], [1965]])
                                             # Klartext
    c = encrypt(m)
    mm = decrypt(c)                         # sollte wieder m geben!
    mn = try_decrypt_with_public_basis(c)   # sollte in der Regel nicht m geben!



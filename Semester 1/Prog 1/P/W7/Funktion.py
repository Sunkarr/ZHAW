def calculate_braking_distance(v0, mu):
    '''
    :param v0: float velocity in m/s
    :param mu: float friction coefficient
    :return: float breaking distance in m
    '''

    g = 9.81

    distance = (0.5 * v0**2)/(mu*g)

    return distance


d1 = calculate_braking_distance(10, 0.3)
print(d1)

d2 = calculate_braking_distance(15, 0.3)
print(d2)
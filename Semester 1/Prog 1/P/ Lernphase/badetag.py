temperaturen = [25, 21, 22, 27, 29, 23, 29]

def optimaler_badetag(temperaturen):
    wochentage = ["MO", "DI", "MI", "DO", "FR", "SA", "SO"]
    maxtempindex = temperaturen.index(max(temperaturen))
    badetag = wochentage[maxtempindex]
    return badetag

print(optimaler_badetag(temperaturen))


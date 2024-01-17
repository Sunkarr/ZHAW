def prim_number(number):
    totalmod = 0
    teiler = []
    anz_teiler = 0
    for index in range(1, number+1):
        modulo = number % index
        if modulo == 0:
            totalmod += 1
            teiler.append(index)
            anz_teiler += 1
    if totalmod == 2:
        result = True, teiler, anz_teiler
    else:
        result = False, teiler, anz_teiler
    return result

def naechst_groessere_primzahl(zahl):
    if prim_number(zahl)[0] == True:
        return zahl
    else:
        while prim_number(zahl)[0] != True:
            zahl += 1
        return zahl

print(prim_number(zahl))
print(naechst_groessere_primzahl(zahl))

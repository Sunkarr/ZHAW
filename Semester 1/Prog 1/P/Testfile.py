wein_sortiment = "204;Benuara Cusumano Sicilia IGP;2012;9.50$\n15;Eximius Primitivo di Manduria;2003;13.50$\n123;Maienfelder Pinot Noir Steinbock;2013;12.60$\n89;Pro Montagna Johannisberg;2011;9.80$\n189;Sierva Bodegas Carchelo Jumilla;2010;11.90$\n111;Primitivo di Mundo perfetto;2001;23.10$"

wein_liste = wein_sortiment.split('\n')  # Split the string into lines

wein_daten = [eintrag.strip().split(';') for eintrag in wein_liste if eintrag.strip()]
print(wein_daten)

nummern = []
namen = []
jahrgang = []
preise = []

for group in wein_daten:
    nummern.append(group[0])
    namen.append(group[1])
    jahrgang.append(group[2])
    preise.append((group[3].replace("$", "")))

"""usernr = input("Type a number: ")
index = nummern.index(usernr)

print(f"Nummer={nummern[index]}")
print(f"Namen={namen[index]}")
print(f"Jahrgang={jahrgang[index]}")
print(f"Preis={preise[index]}")"""


summe = 0
for item in preise:
    summe += float(item)
avg = summe / len(preise)
print(avg)









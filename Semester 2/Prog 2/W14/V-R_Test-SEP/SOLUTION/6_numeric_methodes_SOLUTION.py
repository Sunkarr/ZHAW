'''
Aufgabe 6: Numerische Methoden

Gegeben sei ein folgendes Numpy-Array:
  my_array = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

1) Geben Sie die Selektionsoperatoren für folgende Ausgaben an:
  a) Nur die erste Zeile ([1 2 3])
  b) Die dritte Spalte ([3 6 9])
  c) Die zweite Spalte und die ersten beiden Zeilen ([2 5])

2) Erstellen Sie ein boolesches Array my_boolean_array, bei dem die
  Zelle i,j den Wert 'True' hat, wenn die Zahl in my_array grösser als 5
  ist, sonst 'False'.

3) Schreiben Sie eine Funktion percentarray, welche zu einem zweidimensionalen
  Array ein ebensolches Array zurückliefert, in welchem jedes Feld das 
  Verhältnis vom Ursprungswert zur Ursprungssumme über alle Felder aufweist. 
  Somit muss die Summe über alle Felder des Ergebnisses 1.0 betragen, was mit 
  einem Vergleichsaufruf in Python belegt werden muss.

4) Entwickeln Sie eine Klassendefinition, welche mit einem Array initialisiert 
  wird und anschliessend die in 2) und 3) definierten Funktionalitäten mit 
  einfachen Methodenaufrufen erlaubt.
'''
import numpy as np

print("\n6) Numerische Methoden")

#''' comment this line to activate parts 1 .. 3
my_array = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

# 6.1)
print("\n6.1) Selektionsoperatoren")
print("  a) 1. Zeile:",                    my_array[0])
print("  b) 3. Spalte:",                   my_array[:, 2])
print("  c) 1. + 2. Zeile der 3. Spalte:", my_array[:, 1,][:2])
print("  c) Variante:",                    my_array[:2, 1,])

# 6.2)
print("\n6.2) Boolsches Array: Werte > 5")
print(my_array)
my_boolean_array = my_array > 5
print(my_boolean_array)

# 6.3)
print("\n6.3) percentarry()")

# 1. Variant: one liner
def percentarray_1(array):
    return array / sum(sum(array))

print("  Kontrolle:", sum(sum(my_array)))

# 2. Variant: easy to read
def percentarray_2(array):
    sum = np.sum(array)
    out = array / sum
    return out

def main():
    pc_array = percentarray_1(my_array)
    print("  1. Variante:", np.sum(pc_array))

    pc_array = percentarray_2(my_array)
    print("  2. Variante:", np.sum(pc_array))
#'''

''' comment this line to activate part 4

# 6.4)
class NumericMethodes:
    def __init__(self, array):
        self.__array = array
    
    def bigger_than(self, value):
        bool_array = self.__array > value
        return bool_array
    
    def percentarray(self):
        sum = np.sum(self.__array)
        result = self.__array / sum
        return result

def main():
    print("\n6.4) Klassendefinition\n")
    num_meth = NumericMethodes(np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
    print(num_meth.bigger_than(5), "\n")
    
    perc = num_meth.percentarray()
    print(perc, "\n")

    print(sum(sum(perc)), "\n")
#'''

if __name__ == "__main__":
    main()

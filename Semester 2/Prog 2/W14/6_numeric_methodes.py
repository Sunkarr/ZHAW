'''
Aufgabe 6: Numerische Methoden

Gegeben sei ein folgendes Numpy-Array:
  my_array = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

1) Geben Sie die Selektionsoperatoren für folgende Ausgaben an:
  a) Nur die erste Zeile ([1, 2, 3])
  b) Die dritte Spalte ([3, 6, 9])
  c) Die zweite Spalte und die ersten beiden Zeilen ([2, 5])

2) Erstellen Sie ein ein boolesches Array my_boolean_array, bei dem die
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

my_array = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

aufgabe_1a = my_array[0, :]
aufgabe_1b = my_array[:, 2]
aufgabe_1c = my_array[:2, 1]
print(aufgabe_1a)
print(aufgabe_1b)
print(aufgabe_1c)

aufgabe_2 = my_array > 5
print(aufgabe_2)


def percentarray(arr):
    # Berechne die Summe aller Elemente im ursprünglichen Array
    total_sum = np.sum(arr)

    # Erstelle ein leeres Array mit denselben Abmessungen wie das ursprüngliche Array
    result_array = np.zeros_like(arr, dtype=float)

    # Durchlaufe das ursprüngliche Array und berechne das Verhältnis zum Gesamtsummenwert für jedes Element
    for i in range(arr.shape[0]):
        for j in range(arr.shape[1]):
            result_array[i, j] = arr[i, j] / total_sum

    # Überprüfe, ob die Summe aller Elemente im neuen Array 1.0 beträgt
    assert np.isclose(np.sum(result_array), 1.0), "Die Summe aller Elemente im neuen Array ist nicht 1.0"

    return result_array


# Beispiel Array
example_array = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

# Aufruf der Funktion und Ausgabe des Ergebnisarrays
result = percentarray(example_array)
print("Ergebnisarray:")
print(result)
print(np.sum(result))

import numpy as np


class ArrayHandler:
    def __init__(self, array):
        self.array = np.array(array)

    def select_row(self, row_index):
        return self.array[row_index, :]

    def select_column(self, column_index):
        return self.array[:, column_index]

    def calculate_percent_array(self):
        total_sum = np.sum(self.array)
        percent_array = self.array / total_sum
        assert np.isclose(np.sum(percent_array), 1.0), "Die Summe aller Elemente im neuen Array ist nicht 1.0"
        return percent_array


# Beispielaufrufe
array = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
handler = ArrayHandler(array)

# Beispielaufruf für Aufgabe 2 (Selektion einer Zeile)
print("Selektion der ersten Zeile:", handler.select_row(0))

# Beispielaufruf für Aufgabe 2 (Selektion einer Spalte)
print("Selektion der dritten Spalte:", handler.select_column(2))

# Beispielaufruf für Aufgabe 3 (Berechnung des Prozent-Arrays)
print("Prozent-Array:")
print(handler.calculate_percent_array())

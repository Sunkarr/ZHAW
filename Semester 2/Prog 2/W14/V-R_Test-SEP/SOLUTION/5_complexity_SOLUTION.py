"""
Aufgabe 5: Algorithmische Komplexität / 9 Punkte

Gegeben sei eine Liste variabler Länge von aufsteigenden Zahlen, etwa
[1, 5, 8, 12, 22]. Zwei Algorithmen 'search_a' und 'search_b' zur Bestimmung der
Position einer bestimmten Zahl (Pivotelement) sind implementiert (iterativ und
rekursiv) und sollen bezüglich ihrer Korrektheit und Laufzeiteigenschaften
verglichen werden. Die Funktion 'example' deckt bereits empirisch die
Korrektheit ab.

Die beiden Funktionen 'measurement' (für die Bestimmung einer Ausführung eines
Algorithmus) und 'experiment' sind weiterhin bereits vorbereitet. Aber der
Laborassistent hat sie leider nicht fertig programmieren können. Helfen Sie
mit Ihren Kenntnissen zu Laufzeiteigenschaften aus!

Diese Aufgabe besteht aus drei Teilaufgaben:

1. Vervollständigen Sie die Funktion 'measurement' so, dass die Zeitdauer des
   Aufrufs von 'algo' in *Millisekunden* (Tausendstelsekunden) bestimmt und
   retourniert wird. / 4 Punkte
2. Ersetzen Sie die TODO-Einträge in der Funktion 'experiment' so, dass die
   Messungen mit verschieden langen Listen und gültigen Pivotelementen (in
   Analogie an 'example') durchgeführt werden. Abhängig von Ihrer
   CPU-Geschwindigkeit sind Listenlängen von 10^3 bis 10^8 Elemente empfohlen.
   / 2 Punkte
3. In welche Komplexitätsklassen würden Sie anhand der Ergebnisse die beiden
   Algorithmen einordnen? Mögliche Klassen sind: konstant - konstante Laufzeit
   unabhängig von der Länge der Eingabedaten; linear - Laufzeit wächst
   proportional zur Länge (n) der Eingabe; quadratisch - Laufzeit wächst
   stärker als die Eingabelänge (n²) / 3 Punkte
   > Antwort für search_a:
   > Antwort für search_b:
   > Begründung für die Antworten:
"""

import random
import time

def search_a(l, p):
    for i in range(len(l)):
        if l[i] == p:
            return i

def search_b(l, p, start = None, end = None):
    if start is None:
        start = 0
    if end is None:
        end = len(l)

    mid = start + (end - start) // 2
    result = mid

    if l[mid] < p:
        result = search_b(l, p, mid, end)
    elif l[mid] > p:
        result = search_b(l, p, start, mid)
    
    return result

# Hinweis: Der Listengenerator generiert die beschriebene Liste mit n Elementen
# von aufsteigenden ganzen Zahlen. Mit print(list_generator(5)) können Sie
# beispielsweise eine solche Liste mit 5 Elementen auf die Konsole schreiben.
list_generator = \
    lambda z: sorted(set([random.randrange(z * 10) for i in range(z)]))

def example():
    print("Beispiel für eine kleine Liste:", list_generator(5))
    print("Erzeuge beispielhafte grosse Liste... und bestimme Pivotelement")
    large_liste = list_generator(100_000)
    pivot = random.choice(large_liste)

    print("Suche Pivotelement mit Algorithmus A: ", end = '')
    print(search_a(large_liste, pivot))
    print("Suche Pivotelement mit Algorithmus B: ", end = '')
    print(search_b(large_liste, pivot))

def measurement(algo, args):
    start_ns = time.time_ns()  ###
    algo(*args)
    delta_ms = (time.time_ns() - start_ns) / 1_000_000  ###
    return delta_ms  ###

def experiment():
    for exp in range(3, 9):   ###
        test_list = list_generator(10 ** exp)
        pivot = random.choice(test_list)  ###
        print(f"Laufzeitmessung Algorithmus A für 10^{exp}: ", end = '')
        print(f"{measurement(search_a, (test_list, pivot)):.3f} ms")
        print(f"Laufzeitmessung Algorithmus B für 10^{exp}: ", end = '')
        print(f"{measurement(search_b, (test_list, pivot)):.3f} ms")

if __name__ == "__main__":
    example()
    experiment()

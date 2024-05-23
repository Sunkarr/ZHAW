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
   > Antwort für search_a: Komplexitätsklasse: Linear (O(n))
   > Antwort für search_b: Komplexitätsklasse: Logarithmisch (O(log n))
   > Begründung für die Antworten:
   Der Algorithmus search_a durchläuft die gesamte Liste sequenziell, um das gesuchte Element zu finden. Daher wächst die Laufzeit dieses Algorithmus linear mit der Länge der Eingabeliste. Somit lässt sich search_a in die Komplexitätsklasse Linear (O(n)) einordnen.
   Im Gegensatz dazu verwendet der Algorithmus search_b eine binäre Suchstrategie, bei der die Liste bei jedem Schritt halbiert wird, um das gesuchte Element zu finden. Dies führt zu einer logarithmischen Wachstumsrate der Laufzeit mit der Länge der Eingabeliste. Daher lässt sich search_b in die Komplexitätsklasse Logarithmisch (O(log n)) einordnen.

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

    print("Suche Pivotelement mit Algorithmus A:")
    print(search_a(large_liste, pivot))
    print("Suche Pivotelement mit Algorithmus B:")
    print(search_b(large_liste, pivot))

def measurement(algo, args):
    start_time = time.time()  # Startzeit messen
    algo(*args)  # Aufruf von algo mit den gegebenen Argumenten
    end_time = time.time()  # Endzeit messen
    duration_ms = (end_time - start_time) * 1000  # Dauer in Millisekunden umrechnen
    return duration_ms  # Rückgabe der Dauer in Millisekunden

def experiment():
    for exp in range(3, 9):  # Experimente mit Listenlängen von 10^3 bis 10^8
        test_list = list_generator(10 ** exp)
        pivot = random.choice(test_list)  # Auswahl eines gültigen Pivotelements aus der Liste
        print(f"Laufzeitmessung Algorithmus A für 10^{exp}: ", end = '')
        print(f"{measurement(search_a, (test_list, pivot)):.3f} ms")
        print(f"Laufzeitmessung Algorithmus B für 10^{exp}: ", end = '')
        print(f"{measurement(search_b, (test_list, pivot)):.3f} ms")

if __name__ == "__main__":
    example()
    experiment()
    print(list_generator(5))
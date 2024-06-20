"""
SEP Prog 2
Author: Jonas Bratschi (bratsjon)
Disclaimer: Each of the tasks was created entirely or with the help of ChatGPT,
Google Gemini, Anthropic Claude or similar AI tools.
Date: 20.06.2024


Aufgabe 3: Sortieren und Komplexität (11P)

Antwort zu a):

Im besten Fall benötigt Sunny Sort nur einen Schritt, um die Liste zu sortieren.

Begründung:
Zufällige Reihenfolge: Beim ersten Durchlauf wird die Liste in zwei gleiche Hälften geteilt und jede Hälfte wird unabhängig in eine zufällige Reihenfolge gebracht.
Mittelteile mischen: Danach wird die Liste in vier gleiche Teile geteilt, wobei die mittleren zwei Teile (der 2. und 3. Teil) zusammengefasst und erneut gemischt werden. Die ersten und vierten Teile bleiben unverändert.
Im besten Fall:
Es kann vorkommen, dass die Liste nach dem ersten Zufallsmischen und dem anschließenden Mischen der mittleren Teile bereits in der gewünschten absteigend sortierten Reihenfolge ist.
Das bedeutet, dass im allerbesten Fall, wenn das Zufallsmischen genau so erfolgt, dass die Liste sortiert ist, Sunny Sort nach dem ersten Überprüfen feststellt, dass die Liste sortiert ist und daher sofort beendet wird.

Daher benötigt Sunny Sort im besten Fall nur einen Schritt, um die Liste zu sortieren.

Antwort zu b):

Im schlechtesten Fall benötigt Sunny Sort eine theoretisch unendliche Anzahl von Schritten. Da Sunny Sort auf Zufall basiert, gibt es keine Garantie, dass die Liste jemals sortiert wird, insbesondere bei bestimmten Eingabelisten, bei denen das Zufallsmischen immer wieder zu unsortierten Listen führt.

Begründung:
Zufallselement: Das Verfahren basiert darauf, dass die Liste zufällig gemischt wird und dann überprüft wird, ob sie sortiert ist. Es gibt keine deterministische Komponente, die sicherstellt, dass die Liste nach einer bestimmten Anzahl von Schritten sortiert ist.
Unabhängiges Mischen: Jede Hälfte und die mittleren Teile werden unabhängig voneinander gemischt, was bedeutet, dass es jedes Mal eine neue Zufallsreihenfolge gibt.
Im schlechtesten Fall:
Es könnte theoretisch passieren, dass die Liste nach jedem Mischen nicht sortiert ist. Da das Mischen zufällig erfolgt, gibt es keine Obergrenze für die Anzahl der Schritte, die erforderlich sind, um die Liste zu sortieren.
Daher lautet die Antwort:

Sunny Sort kann im schlechtesten Fall eine theoretisch unendliche Anzahl von Schritten benötigen.

Antwort/Code zu c):
"""

# Code in sort + mix ergänzen. Die Methode check ist bereits vollständig.
# WICHTIG: Die Lösung wird auch gewertet, wenn die Umsetzung nicht rekursiv erfolgt.

import random

class SunnySort:
    @staticmethod
    def sort(l):
        """
        l: list of int
        Returns: l sorted in descending order
        Uses 'SunnySort' as sorting algorithm
        """
        if SunnySort.check(l):
            return l
        else:
            SunnySort.mix(l)
            return SunnySort.sort(l)

    @staticmethod
    def mix(l):
        """
        l: list of int
        Returns: a randomly shuffled version of l
        """
        n = len(l)
        half = n // 2
        quarter = n // 4

        # Step 1: Divide the list into two halves and shuffle each half
        first_half = l[:half]
        second_half = l[half:]
        random.shuffle(first_half)
        random.shuffle(second_half)

        # Combine the shuffled halves back together
        l[:half] = first_half
        l[half:] = second_half

        # Step 2: Divide the list into four parts and shuffle the middle parts
        first_part = l[:quarter]
        middle_parts = l[quarter:3 * quarter]
        last_part = l[3 * quarter:]

        random.shuffle(middle_parts)

        # Combine the parts back together
        l[:quarter] = first_part
        l[quarter:3 * quarter] = middle_parts
        l[3 * quarter:] = last_part

    @staticmethod
    def check(l):
        """
        l: list of int
        Returns: True if l is sorted in descending order, False otherwise
        """
        # Already completed
        for index in range(len(l) - 1):
            if not (l[index] > l[index + 1]):
                return False
        return True


# Test code
s = SunnySort
a = [7, 6, 5, 4]
b = [2, 3, 7, 1]

print("a: ", s.check(a))
print("b: ", s.check(b))
print("m: ", s.mix(a))
print("m: ", s.mix(b))
print("s: ", s.sort(a))
print("s: ", s.sort(b))

"""
Antwort zu d):

Sunny Sort ist für den produktiven Einsatz ungeeignet. Hier sind einige Gründe:

1. Zufälligkeit und Unvorhersehbarkeit
Sunny Sort basiert auf zufälligem Mischen der Liste. Es gibt keine Garantie, dass die Liste jemals sortiert wird, da der Prozess rein zufällig ist. Im schlechtesten Fall kann das Verfahren theoretisch unendlich lange laufen.

2. Ineffizienz
Da Sunny Sort die Liste zufällig mischt und dann überprüft, ob sie sortiert ist, ist das Verfahren extrem ineffizient. Andere, deterministische Sortieralgorithmen wie Quicksort, Mergesort oder Heapsort haben wohldefinierte Laufzeiteigenschaften und sind in der Praxis deutlich schneller und zuverlässiger.

3. Fehlende Optimierungen
Sunny Sort nutzt keine der bekannten Optimierungen oder Techniken, die in gängigen Sortieralgorithmen verwendet werden. Algorithmen wie Timsort (in Python verwendet) oder Quicksort haben Optimierungen, die sie für reale Anwendungen effizient und schnell machen.

4. Unvorhersehbare Leistung
Da Sunny Sort auf Zufall basiert, ist die Leistung extrem unvorhersehbar. Ein Produktionssystem benötigt konsistente und vorhersagbare Laufzeiten, um zuverlässig zu funktionieren. Sunny Sort kann keine solche Garantie bieten.

5. Fehlende Garantie auf korrekte Sortierung
Obwohl Sunny Sort theoretisch irgendwann zu einer sortierten Liste führen kann, gibt es keine Garantie, dass dies innerhalb einer akzeptablen Zeit geschieht. Dies ist ein großes Risiko für den produktiven Einsatz.

Zusammenfassung
Sunny Sort ist eher eine theoretische oder spielerische Annäherung an das Problem des Sortierens, aber für den produktiven Einsatz in einer realen Anwendung ist es aufgrund seiner Zufälligkeit, Ineffizienz und Unvorhersehbarkeit absolut ungeeignet. Stattdessen sollten bewährte, effiziente und deterministische Sortieralgorithmen verwendet werden, die konsistente und schnelle Ergebnisse liefern.


Antwort zu e):

Beste Fall: Anpassung der Aufwände (a)
Im besten Fall benötigt Sunny Sort nur einen Schritt, um die Liste zu sortieren, wenn die zufälligen Mischungen zufällig die Liste in die korrekte Reihenfolge bringen. Dies ändert sich nicht mit der Optimierung, da der beste Fall bereits nach dem ersten Schritt erreicht wird und somit Quicksort nicht benötigt wird. Der Aufwand bleibt daher O(1) im besten Fall.

Schlechteste Fall: Anpassung der Aufwände (b)
Im schlechtesten Fall kann Sunny Sort ohne Optimierung eine theoretisch unendliche Anzahl von Schritten benötigen, da die Liste zufällig gemischt wird und es keine Garantie gibt, dass sie jemals sortiert wird. Der Aufwand ist also nicht definiert und praktisch nicht nutzbar.

Mit der Optimierung:

1. Erste 8 Schritte Sunny Sort:
In jedem dieser Schritte wird die Liste zufällig gemischt. Jeder dieser Schritte hat einen konstanten Zeitaufwand O(n) für das Mischen und Überprüfen der Liste. Nach 8 Schritten beträgt der maximale Aufwand also 8⋅O(n) = O(n).

2. Umschaltung zu Quicksort:
Quicksort hat im schlimmsten Fall einen Zeitaufwand von O(n^2), aber im Durchschnitt O(n log n).

Zusammengefasster Aufwand im schlechtesten Fall:
- Sunny Sort für 8 Schritte: O(n)
- Quicksort danach: O(n log n)

Der kombinierte maximale Aufwand im schlechtesten Fall ist also O(n) + O(n log n) = O(n log n).

Fazit
- Bester Fall: Der Aufwand bleibt O(1), da im besten Fall die Liste bereits nach dem ersten Schritt sortiert ist.
- Schlechtester Fall: Der Aufwand reduziert sich von unbestimmt/unendlich (ohne Umschaltung) auf O(n log n) durch die Umschaltung auf Quicksort nach 8 rekursiven Schritten.

Diese Optimierung macht Sunny Sort praktikabler und garantiert eine obere Schranke für den Aufwand im schlechtesten Fall, was den Algorithmus zuverlässiger und nutzbarer macht.

"""
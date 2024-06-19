"""
Aufgabe 3: Dynamische Pandas-Tabellen / 14 Punkte

Das Gesetz der grossen Zahlen besagt, dass mit zunehmender Durchführung eines
Zufallsexperiments der Ergebniswert gegen den Erwartungswert konvergiert. Das
Gesetz soll mit Hilfe von Pandas empirisch validiert werden.

Dazu werden in mehreren Runden (runden / abstand) Zufallswerte im Bereich
[minwert..maxwert] gebildet, und zwar in aufsteigender Zahl abhängig von der
Runde. Diese Zufallswerte werden in eine Tabelle eingetragen und davon jeweils
am Ende der Runde der Mittelwert gebildet. Die Tabelle wird anschliessend
wieder geleert. Die Differenz zwischen Mittel- und Erwartungswert wird in eine
zweite Tabelle eingetragen und diese anschliessend visualisiert.

Diese Aufgabe besteht aus vier Teilaufgaben:

1. Erzeugen Sie im Konstruktor zwei leere Dataframes, für die zu mittelnden
   Zufallswerte (dfmittel) und für die zu visualisierenden Differenzen
   (dfvis), mit jeweils einer Wertspalte, als Attribute. Legen Sie dazu zuerst
   zwei Dictionaries je einer leeren Liste als Wert zu einem selbstgewählten
   Schlüsselnamen an. / 4 Punkte
2. Ergänzen Sie die Methode zufallsroutine um die Berechnung des arithmetischen
   Mittels, die Bildung der Differenz, und die Erweiterung der Differenztabelle
   um diese. Der Mechanismus zur Erweiterung der Tabelle ist in der vorherigen
   for-Schleife erkennbar und kann übertragen werden. / 6 Punkte
3. Ergänzen Sie das Hauptprogramm um den Aufruf der Methode zufallsroutine mit
   der Parameterisierung: minwert=0, maxwert=10, 1000 Runden bei Abstand 50.
   Das Hauptprogramm soll per Guard geschützt sein, so dass es bei Einbindung
   der Python-Datei als Modul nicht ausgeführt wird. / 3 Punkte
4. Speichern Sie die resultierende Visualisierung als Bilddatei und geben Sie
   diese mit ab. Hinweis: In der Plotansicht in Spyder dazu auf den ersten
   Button oben links in der Toolbar klicken ("Save Plot as") / 1 Punkt
"""

import pandas
import random
import time

class PandasValidation:
    def __init__(self):
        # Teilaufgabe 1
        # # #
        mean = {"Mean": []}
        self.dfmittel = pandas.DataFrame(mean)

        difference = {"Diff": []}
        self.dfvis = pandas.DataFrame(difference)
        # # #

    def random_runner(self, value_min, value_max, rounds, spacing):
        mean_expected = (value_max - value_min) / 2
        for size in range(1, rounds, spacing):
            self.dfmittel = self.dfmittel.head(0)
            for i in range(size):
                value_random = random.randrange(value_min, value_max + 1)
                self.dfmittel.loc[i] = value_random
            # Teilaufgabe 2 hier ergänzen
            # # #
            mean_calculated = self.dfmittel["Mean"].mean()
            mean_difference = abs(mean_expected - mean_calculated)
            self.dfvis.loc[size] = mean_difference
            # # #
        self.dfvis.plot(title=str(time.time()))

# Teilaufgabe 3 hier ergänzen
# # #
if __name__ == "__main__":
    mean_differences = PandasValidation()
    mean_differences.random_runner(0, 10, 1000, 50)
# # #

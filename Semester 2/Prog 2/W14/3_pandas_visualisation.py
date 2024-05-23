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
2. Ergänzen Sie die Methode random_runner um die Berechnung des arithmetischen
   Mittels, die Bildung der Differenz, und die Erweiterung der Differenztabelle
   um diese. Der Mechanismus zur Erweiterung der Tabelle ist in der vorherigen
   for-Schleife erkennbar und kann übertragen werden. / 6 Punkte
3. Ergänzen Sie das Hauptprogramm um den Aufruf der Methode random_runner mit
   der Parameterisierung: minwert=0, maxwert=10, 1000 Runden bei Abstand 50.
   Das Hauptprogramm soll per Guard geschützt sein, so dass es bei Einbindung
   der Python-Datei als Modul nicht ausgeführt wird. / 3 Punkte
4. Speichern Sie die resultierende Visualisierung als Bilddatei und geben Sie
   diese mit ab. Hinweis: In der Plotansicht in Spyder dazu auf den ersten
   Button oben links in der Toolbar klicken ("Save Plot as") / 1 Punkt
"""

import pandas as pd
import random
import time
import matplotlib.pyplot as plt


class PandasValidation:
    def __init__(self):
        # Teilaufgabe 1: Erstellung der leeren DataFrames
        self.dfmittel = pd.DataFrame({'values': []})
        self.dfvis = pd.DataFrame({'differences': []})

    def random_runner(self, value_min, value_max, rounds, spacing):
        mean_expected = (value_max + value_min) / 2
        for size in range(1, rounds + 1, spacing):
            self.dfmittel = self.dfmittel.iloc[0:0]  # Leeren des DataFrames
            for i in range(size):
                value_random = random.randint(value_min, value_max)
                self.dfmittel.loc[i] = value_random
            # Teilaufgabe 2: Berechnung des arithmetischen Mittels und der Differenz
            mean_observed = self.dfmittel['values'].mean()
            difference = abs(mean_observed - mean_expected)
            self.dfvis = pd.concat([self.dfvis, pd.DataFrame({'differences': [difference]})], ignore_index=True)

        # Visualisierung
        self.dfvis.plot(title='Differenzen zum Erwartungswert')
        plt.savefig("visualisierung.png")  # Teilaufgabe 4: Speichern der Visualisierung als Bilddatei
        plt.show()


# Teilaufgabe 3: Aufruf der Methode random_runner im Hauptprogramm
if __name__ == "__main__":
    pv = PandasValidation()
    pv.random_runner(0, 10, 1000, 50)

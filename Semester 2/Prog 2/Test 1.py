"""- Aufgabenstellung:

Betrachten sie das sortierverfahren sunny sort die eingabe ist eine liste der länge n aus integers
das ergebnis ist ebenfalls eine liste von integers absteigend sortiert
zur sortierung benutzt sunny sort das folgende verfahren:

1. die liste wird in 2 gleiche hälften unterteilt
jede hälfte wird unabhängig gemischt dh in eine zufällige reihenfolge gebracht

2. in einem zweiten schritt wird die liste in 4 gleiche tiele geteilt
der mittlere teil dh der 2. und 3. teile werden zusammengenommen und ebenfalls gemischt
der 1. und 4. teil der liste bleibt in diesem schritt unverändert

Schritt "check"

3. nun wird getestet ob die gesamte liste sortiert ist
falls nicht wird der Vorgang wiederholt
falls sie sortiert ist wird sie zurück geliefert un das verfahren ist beendet
zur vereinfachung ist n mindestens 4 und immer durch 4 teilbar"""


"""schreiben sie in pass.py eine python funktion, welche prüft ob ein neu anzulegendes passwort die folgenden regeln erfüllt:

1. minimum 7 zeichen
2. keine wiederholten zeichen
3. muss mindestens drei dieser vier kategorien beinhalten:
- Kleinbuchstaben
- Grossbuchstaben
- Ziffern
- Sonderzeichen

Gültige Zeichen:
- a-z
- A-Z
- 0-9
- Leerschlag
-Symbole:
!\"#$%&'()*+,./:;<=>?[]\\^_`{|}~-
"""
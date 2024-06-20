"""
SEP Prog 2
Author: Jonas Bratschi (bratsjon)
Disclaimer: Each of the tasks was created entirely or with the help of ChatGPT,
Google Gemini, Anthropic Claude or similar AI tools.
Date: 20.06.2024

Aufgabe 4: Klassen modellieren mit Tieren (16P)

Ein Bauer hat vier Schafe, welche sich nebst dem Namen in insgesamt drei
Wesensmerkmalen unterscheiden. Er möchte die Tiere, welche in der Datei
schafe.pdf abgebildet sind, programmatisch digitalisieren.

Entwickeln Sie eine geeignete methodenlose Python-Klassendefinition mit
versteckten Attributen für die unterschiedlichen Eigenschaften der Tiere
und einem zweckmässig parametrisierten Konstruktor. Der Tiername soll
nicht als Attribut geführt werden. (5P)

Legen Sie in einem geeignet markierten Hauptprogramm für jedes Schaf
zudem eine Beispielinstanz an, deren Objektnamen die Zuordnung zum
jeweiligen Schaf eindeutig widerspiegelt. (3P)

Ergänzen Sie anschliessend eine Methode, damit Bruno gelegentlich auch
ohne sein Zubehör unterwegs sein kann. Versehen Sie die Methode mit
einer minimalen Dokumentation (Einzeiler) um den Zweck der Methode zu
verstehen. (3P)

Führen Sie schliesslich per Vererbung eine Klasse Leitschaf mit
optimiertem Konstruktor ein. Ein Leitschaf hat immer eine Glocke, aber
auch ein weiteres Merkmal, eine essentielle Altersangabe.
Geben Sie auch hierfür im Hauptprogramm ein Beispiel für Brunos
Schwester Brunhilde. Sie trägt das gleiche Fell wie ihr Bruder, aber
keine Hörner, und wurde zu Weihnachten 2017 geboren. (5P)
"""

class Schaf:
    def __init__(self, fellfarbe, hoerner, zubehoer):
        self.__fellfarbe = fellfarbe
        self.__hoerner = hoerner
        self.__zubehoer = zubehoer

    def entferne_zubehoer(self):
        """Entfernt das Zubehör des Schafes. (Bruno)"""
        self.__zubehoer = None

    # Methoden zum Zugriff auf die Attribute (optional, für den Fall, dass du Zugriff brauchst)
    def get_fellfarbe(self):
        return self.__fellfarbe

    def get_hoerner(self):
        return self.__hoerner

    def get_zubehoer(self):
        return self.__zubehoer


class Leitschaf(Schaf):
    def __init__(self, fellfarbe, hoerner, geburtsjahr):
        # Ein Leitschaf hat immer eine Glocke
        super().__init__(fellfarbe, hoerner, 'Glocke')
        self.__geburtsjahr = geburtsjahr

    def get_geburtsjahr(self):
        return self.__geburtsjahr

    def entferne_zubehoer(self):
        """Ein Leitschaf kann sein Zubehör (Glocke) nicht entfernen."""
        print("Das Zubehör eines Leitschafs kann nicht entfernt werden.")
        pass


# Hauptprogramm
# Beispielinstanzen der Schafe
flocon = Schaf('weiss', True, None)
lamberto = Schaf('schwarz', True, None)
neige = Schaf('weiss', False, None)
bruno = Schaf('weiss', True, 'Glocke')

# Beispielinstanz für Brunos Schwester Brunhilde, das Leitschaf
brunhilde = Leitschaf('braun', False, 2017)

# Test der Methode entferne_zubehoer für Bruno und Brunhilde
bruno.entferne_zubehoer()
brunhilde.entferne_zubehoer()

# Ausgabe der Eigenschaften zum Testen (optional)
print(f"Flocon: Fellfarbe={flocon.get_fellfarbe()}, Hörner={flocon.get_hoerner()}, Zubehör={flocon.get_zubehoer()}")
print(f"Lamberto: Fellfarbe={lamberto.get_fellfarbe()}, Hörner={lamberto.get_hoerner()}, Zubehör={lamberto.get_zubehoer()}")
print(f"Neige: Fellfarbe={neige.get_fellfarbe()}, Hörner={neige.get_hoerner()}, Zubehör={neige.get_zubehoer()}")
print(f"Bruno: Fellfarbe={bruno.get_fellfarbe()}, Hörner={bruno.get_hoerner()}, Zubehör={bruno.get_zubehoer()}")
print(f"Brunhilde: Fellfarbe={brunhilde.get_fellfarbe()}, Hörner={brunhilde.get_hoerner()}, Zubehör={brunhilde.get_zubehoer()}, Geburtsjahr={brunhilde.get_geburtsjahr()}")

"""
SEP Prog 2
Author: Jonas Bratschi (bratsjon)
Disclaimer: Each of the tasks was created entirely or with the help of ChatGPT,
Google Gemini, Anthropic Claude or similar AI tools.
Date: 20.06.2024


Aufgabe 5: Umgang mit dem Internet (18P)

a) 6P: Vervollständigen Sie die nachfolgende Funktion bis sie funktioniert und eine Antwort liefert.
Die Antwort muss aus einem Geheimwort (Substantiv in beliebig deklinierter Form) bestehen und soll menschenlesbar,
also nicht in Binärform, typisiert sein. Tragen Sie anschliessend das retournierte Geheimwort unten ein.
Hinweis: Die Anfrage wird nur funktionieren, wenn Sie hinter die Portnummer einen Pfad anhängen
zusammengesetzt aus dem Wort "secret" und der Zahl 3875.

Geheimwort:
"""

import urllib.request

def geheimcode():
    url = "http://160.85.252.148:12347/secret3875"
    headers = {
        'X-Key': '406'
    }
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req) as response:
        secret_word = response.read().decode('utf-8')
    return secret_word

print(geheimcode())

"""
b) 6P: Die nachfolgende Funktion soll über das Internet auf Port 1155 bereitgestellt werden.
Unter keinen Umständen darf sie vor der letzten Return-Anweisung unkontrolliert abbrechen.
Identifizieren Sie drei kritische Abbruchpunkte und sichern Sie diese über geeignete Massnahmen direkt am Funktionsanfang ab.
"""

def netzfunktion(g: int, q) -> int:
    # Massnahmenbeginn
    if not isinstance(g, int):
        raise ValueError("Der Parameter 'g' muss ein Integer sein.")
    if g == -1:
        raise ValueError("Der Parameter 'g' darf nicht -1 sein, um eine Division durch null zu vermeiden.")
    if not isinstance(q, str):
        raise ValueError("Der Parameter 'q' muss eine Zeichenkette sein.")
    # Massnahmenende

    try:
        g += 1
        z = 42 / g
        if str(z) in q:
            g -= g
    except Exception as e:
        print(f"Ein Fehler ist aufgetreten: {e}")
        return -1
    return g

"""
c) 6P: Strukturierte Daten werden oft im portablen JSON-Format über das Internet übertragen.
Sie erhalten nun eine kulinarische Nachricht in ebenjenem Format.
Komplettieren Sie die Empfangsfunktion zur Extraktion der menschenlesbaren
Nachricht aus den über das Netzwerk empfangenen Daten.
Hinweis: Die Nachricht ist mehrfach kodiert. Probieren Sie allenfalls unterschiedliche Dekodierungen aus.
Weiterer Hinweis: Für eine der Dekodierungen ist eine auf "decode" endende Funktion aus dem Modul "base64" nützlich,
welche Sie allenfalls in der Python-Hilfe nachschlagen müssen.
"""

import json
import base64


def empfang(n: bytes) -> str:
    try:
        # Schritt 1: JSON-Daten dekodieren
        decoded_json = json.loads(n)

        # Schritt 2: Extrahieren der Base64-kodierten Nachricht
        base64_message = decoded_json[0]['text']

        # Schritt 3: Base64-Dekodierung
        decoded_message = base64.b64decode(base64_message).decode('utf-8')

        return decoded_message
    except Exception as e:
        return f"Ein Fehler ist aufgetreten: {e}"


print(empfang(b'[{"text": "R2Viw6Rjaw=="}]'))

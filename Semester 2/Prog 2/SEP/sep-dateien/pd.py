"""
SEP Prog 2
Author: Jonas Bratschi (bratsjon)
Disclaimer: Each of the tasks was created entirely or with the help of ChatGPT,
Google Gemini, Anthropic Claude or similar AI tools.
Date: 20.06.2024


Aufgabe 6: Tabellendaten (13P)

Ein Buchladen hält seine Daten in verkauf.csv, kunden.csv, buchliste.csv und preise.csv.
Von besonderem Interesse ist die dritte Datei. Ein kleiner Ausschnitt, die Datei ist viel länger:
    
Autor,Titel,Erscheinungsjahr
Austin;Jane, Stolz und Vorurteil, 1813
Dickens;Charles, A Tale of two Cities, 1859
Dickens;Charles, Great Expectations, 1861
"""
 
"""
1) 3P: Lesen Sie die relevante Datei mit Pandas ein und erstellen Sie eine geeignete Datenstruktur.
Verwenden Sie diese Struktur für die nächsten Teilaufgaben.
"""

import pandas as pd
import matplotlib.pyplot as plt

# Einlesen der CSV-Datei in ein DataFrame
buchliste_df = pd.read_csv('buchliste.csv', delimiter=',', encoding='utf-8')

# Ersetzen von Semikolon durch Leerzeichen in der Spalte "Autor"
buchliste_df['Autor'] = buchliste_df['Autor'].str.replace(';', ' ')

# Anzeigen des DataFrames
print(buchliste_df)


"""
2) 1P: Welche Bücher des Autors "Charles Dickens" finden sich in der Liste? Geben Sie diese auf der Konsole aus.
"""

# Bücher von Charles Dickens filtern
charles_dickens_buecher = buchliste_df[buchliste_df['Autor'] == 'Dickens Charles']

# Ausgabe der Bücher auf der Konsole
print(charles_dickens_buecher)



"""
3) 2P: Welche Bücher der Autorin "Jane Austin" sind nach 1800 erschienen? Geben Sie diese auf der Konsole aus.
"""

# Bücher von Jane Austin filtern, die nach 1800 erschienen sind
jane_austin_buecher = buchliste_df[(buchliste_df['Autor'] == 'Austin Jane') & (buchliste_df['Erscheinungsjahr'] > 1800)]

# Ausgabe der Bücher auf der Konsole
print(jane_austin_buecher)



"""
4) 1P: Wie viele unterschiedliche Autoren sind in der Tabelle enthalten? Geben Sie diese auf der Konsole aus.
"""

# Anzahl der unterschiedlichen Autoren ermitteln
anzahl_autoren = buchliste_df['Autor'].nunique()

# Ausgabe der Anzahl der unterschiedlichen Autoren auf der Konsole
print(f"Anzahl der unterschiedlichen Autoren: {anzahl_autoren}")



"""
5) 3P: Generieren Sie einen Barplot, bei dem in der X-Achse das Erscheinungsjahr und in der Y-Achse die Anzahl der Bücher,
die in diesem Jahr erschienen sind, angezeigt werden.
Die Lösung sollte eine Anzahl an Zeilen aufweisen, die um eins geringer als die Zahl der erzielbaren Punkte in dieser Teilaufgabe ist.
"""

buchliste_df = pd.read_csv('buchliste.csv', delimiter=',', encoding='utf-8').assign(Autor=lambda df: df['Autor'].str.replace(';', ' ')).Erscheinungsjahr.value_counts().sort_index().plot(kind='bar', figsize=(10, 6), xlabel='Erscheinungsjahr', ylabel='Anzahl der Bücher', title='Anzahl der Bücher pro Erscheinungsjahr')
plt.show()

"""
6) 3P: Übersetzen Sie automatisiert den Titel der personenreferenzierenden Spalte,
indem Sie deren deutschsprachigen Titel durch einen anderssprachigen ersetzen.
Konsultieren Sie hierfür die Methode rename der Buchdatenstruktur nach dem Schema rename(..., axis="columns").
Nehmen Sie weiterhin an, eine geeignete und verpflichtend zu nutzende Übersetzungsdatei words.csv mit
folgendem Format vorliegen zu haben.

dt|en
Apfel|apple
Autor|author
"""

# Einlesen der Buchliste
buchliste_df = pd.read_csv('buchliste.csv', delimiter=',', encoding='utf-8')
buchliste_df['Autor'] = buchliste_df['Autor'].str.replace(';', ' ')

# Einlesen der Übersetzungsdatei
words_df = pd.read_csv('words.csv', delimiter='|', encoding='utf-8')

# Erstellen eines Übersetzungs-Dictionarys
translation_dict = dict(zip(words_df['en'], words_df['dt']))

# Übersetzen der Buchtitel
def translate_title(title, translation_dict):
    words = title.split()
    translated_words = [translation_dict.get(word, word) for word in words]
    return ' '.join(translated_words)

buchliste_df['Titel'] = buchliste_df['Titel'].apply(lambda x: translate_title(x, translation_dict))

# Anzeige der neuen Buchliste
print(buchliste_df)


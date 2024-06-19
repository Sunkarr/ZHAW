# -*- coding: utf-8 -*-
"""
Die Klasse "NewsFeed" mit der Methode get_news soll Neuigkeiten im JSON-Format 
lesen und ausgeben können. Das JSON hat folgende Struktur:
    Articles': [{
        'title': 'Neuer Präsident in China',
        'description': 'In China ist ein neuer Präsident gewählt ...'
    },
    {
        'title': 'FC Thun ist Schweizer Meister',
        'description': 'FC Thun ist neuer Schweizer Meister ...'
    }]

1) Entwickeln Sie die Klasse NewsFeed mit den folgenden beiden Methoden:
   - Die Methode get_news() für das Lesen der Daten von der fiktiven
     URL "https://mynews.ch" sowie das Parsen mit dem JSON-Modul. Die Methode 
     soll den geparsten Newstext zurückliefern.
   - Die Methode print_titles(), welche die Methode get_news() aufruft und aus 
     der Rückgabe sämtliche Nachrichtentitel auf der Konsole ausgibt.

2) Instanziieren Sie die Klasse NewsFeed und rufen Sie die Methode
   print_titles() auf.

3) Die Methode get_news() liest die Daten vom Server, was länger dauern kann. 
   Was ist aus diesem Grund der bevorzugte Ansatz? Zeigen Sie skizzenmässig eine
   mögliche Implementierung auf.
"""
import json
import urllib.request



print("\n2) Nachrichtensammler")



# 2.1) Klasse
class NewsFeed():
    # 2.1) 1. Methode
    def get_news(self):
        '''
        - lesen der Daten von der URL "https://mynews.ch"
        - parsen mit dem JSON-Modul
        - Rückgabe des geparsten Newstext
        '''
            
        ''' uncomment this line to activate code block
        # get date from internet
        url = "https://mynews.ch"
        f = urllib.request.urlopen(url)
        data = f.read()
    
        # parse data    
        data_parsed = json.loads(data.decode('utf-8'))
        #'''
    
        #''' uncomment this line to activate code block
        # fill data_parsed with test content
        data_parsed = {
            'Articles': [{
                'title': 'Neuer Präsident in China',
                'description': 'In China ist ein neuer Präsident gewählt ...'
            },
            {
                'title': 'FC Thun ist Schweizer Meister',
                'description': 'FC Thun ist neuer Schweizer Meister ...'
            }]
        }
        #'''
        
        return data_parsed["Articles"]
    
    
    
    # 2.1) 2. Methode
    def print_titles(self):
        '''
        - ruf get_news() auf
        - gibt sämtliche Nachrichtentitel auf Konsole aus
        '''
        texts = self.get_news()
        for text in texts:
            print(text["title"])



# 2.2) Instanzierung, Methodenaufruf
if __name__ == "__main__":
    feeder = NewsFeed()    # instance of class NewsFeed
    feeder.print_titles()  # call print_titles()

    # 2.3)
    print("\n2.3) Daten lesen verschnellern (weil get_news() länger dauert)")
    print("get_news() gets called")
    print("    if cache not present or outdated:")
    print("        store received data in cache, store date + time too")
    print("    read data from cache")
    print("    return data")

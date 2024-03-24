# -*- coding: utf-8 -*-
"""
PROG2 V05-13: public open data
"""

import urllib.request as ur
import urllib.parse as up
import json
import time



class ConnectionInfo:
    def __init__(self, station):
        urlbase = "http://transport.opendata.ch/v1/stationboard"
        self.url = urlbase + "?station=" + up.quote(station)
        # => http://transport.opendata.ch/v1/stationboard?station=Winterthur%20HB

    def show(self, number):
        s = ur.urlopen(self.url).read().decode("utf-8")
        # => {"station":{"id":"8506899","name":"Winterthur, Hauptbahnhof","score":null,"coord ...

        stations = json.loads(s)

        print("Your next connections:")
        for entry in stations["stationboard"][:number]:
            print(
                "Bus", 
                entry["number"], 
                "to", 
                entry["to"], 
                "in",
                round(entry["stop"]["departureTimestamp"] - time.time()), 
                "seconds"
            )


"""
- "Winterthur" is Train Station
- "Winterthur HB" is Bus Station
- "Winterthur Technikum" is Bus Stop in front of ZHAW
- try Stations you know
- try to print more data (see doku: https://transport.opendata.ch/docs.html
"""
c = ConnectionInfo("Winterthur HB")
c.show(5)  # limit number next connections by slicing

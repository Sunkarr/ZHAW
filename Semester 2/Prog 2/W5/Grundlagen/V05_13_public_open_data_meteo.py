# -*- coding: utf-8 -*-
"""
PROG2 V05-13: public open meteo data

Meteoschweiz: https://www.meteoschweiz.admin.ch/home.html?tab=overview

Maps: https://map.geo.admin.ch/ - Windböe 1 s, Max. 10 min

Daten vom Bundesamt: https://data.geo.admin.ch/

Datensatz: https://data.geo.admin.ch/ch.meteoschweiz.messwerte-wind-boeenspitze-kmh-10min/

JSON Datei: https://data.geo.admin.ch/ch.meteoschweiz.messwerte-wind-boeenspitze-kmh-10min/ch.meteoschweiz.messwerte-wind-boeenspitze-kmh-10min_en.json
"""

import urllib.request
import json
url = "https://data.geo.admin.ch/ch.meteoschweiz.messwerte-wind-boeenspitze-kmh-10min/ch.meteoschweiz.messwerte-wind-boeenspitze-kmh-10min_en.json"

# get data
f      = urllib.request.urlopen(url)
daten  = json.load(f)

# filter data
points = [p for p in daten['features'] if 5 < p['properties']['value'] < 150]
unit   = points[0]['properties']['unit']

# print data
for point in points:
	# print('{:30s}{:5.2f} {:5s}'.format(point['properties']['station_name'], point['properties']['value'], unit))
	print(
		f"{point['properties']['station_name']:30s}" +
		f"{point['properties']['value']:5.2f} " +
		f"{unit:5s}"
	)

# calculate average
sum_1 = 0
for point in points:
  sum_1 += point['properties']['value']

avg_1 = sum_1 / len(points)

print(f"avg: {avg_1:5.2f} {unit:5s}")

# calculate average with list comprehension
# print("avg: {:5.2f} {:5s}".format(sum([p['properties']['value'] for p in points]) / len(points), unit))

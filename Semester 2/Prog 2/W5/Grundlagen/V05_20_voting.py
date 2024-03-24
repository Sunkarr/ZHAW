# -*- coding: utf-8 -*-
"""
PROG2 V05-20: real worl data example - voting results canton of Zurich
"""
import urllib.request
import json

url   = "https://www.wahlen.zh.ch/abstimmungen/2021_03_07/viewer_download.php"
vf    = urllib.request.urlopen(url)
votes = json.load(vf)

for wk in range(len(votes["GEBIETE"])):
    area = votes["GEBIETE"][wk]
    if "JA_PROZENT" in area["VORLAGEN"][1]:
      print(
  			  "In",    area["NAME"],
  				"haben", area["VORLAGEN"][1]["JA_PROZENT"],
  				"für",   area["VORLAGEN"][1]["VORLAGE_NAME"],
  				"gestimmt."
  		)

# -*- coding: utf-8 -*-
"""
PROG2 V05-16: asynchronous processing

20.03.2024 URL with id doesn't work anymore ==> example doesn't work

1. https://www.stadt-zuerich.ch/geodaten/
2. Suche: "haltestellen des öffentlichen verkehrs"
3. Datenbezug: Ausschnitt = Stadt Zürich, Format = csv, Download
4. Meine Bestellungen: warten bis bereit, manueller Download
"""

import multiprocessing
import urllib.request
import time



# Synchronous download function
# - Downloads a CSV document on stops from a URL, counts the number of lines, 
#   and thus calculates the number of stops in the city of Zurich
#   (should be around 740)
# - url is of type: str
def count_stops(url):
    f = urllib.request.urlopen(url)
    s = f.read().decode()
    return len(s.split("\n")) - 1



# Asynchronous download wrapper function
# - This method calls the synchronous function, and writes the result into a
#   supplied queue so that the main script running in parallel can read this
#   result later on (after function termination)
# - q is of type: multiprocessing.Queue
def count_stops_async(url, q):
    q.put(count_stops(url))



if __name__ == '__main__':
	url = "https://data.stadt-zuerich.ch/dataset/92f198dc-b405-4234-ae17-09b3f2889092/resource/7bb0405f-c009-498a-bc7c-d42bf7664e5f/download/haltestelle.csv"

	# 1. synchronous download - script is blocked
	print(f"\n{time.time():.2f} synchronous download - Bitte warten...")
	start = time.time()
	stops = count_stops(url)
	print(f"\nIn der Stadt Zürich gibt es {stops} Haltestellen - request time: {time.time() - start:.2f} sec.")

	# 2. asynchronous download - script is not blocked
	print(f"\n{time.time():.2f} asynchronous download - Bitte warten...")
	start = time.time()
	q = multiprocessing.Queue()
	p = multiprocessing.Process(target = count_stops_async, args = (url, q))
	p.start()
	while True:
		try:
			# Attempt to read number out of queue
			stops = q.get(False)
			print(f"\nIn der Stadt Zürich gibt es {stops} Haltestellen - request time: {time.time() - start:.2f} sec.")
			break
		except:
			# Here some other tasks can be processed
			#current_milli_time = lambda: int(round(time.time() * 1000))
			print(f"{time.time():.2f} Bitte noch etwas warten...")
			time.sleep(0.1)
	p.join()
	print("\nDone!")

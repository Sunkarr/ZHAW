# -*- coding: utf-8 -*-
"""
PROG2 V05-12: urllib module

playing around with an API

references:
[1] API Documentation: https://alexwohlbruck.github.io/cat-facts/docs/
[2] cat-facts:
    https://alexwohlbruck.github.io/cat-facts/docs/endpoints/facts.html
"""

import urllib.request
import urllib.parse
import json

baseurl = "https://cat-fact.herokuapp.com"
request = "/facts/random?"
parameters = urllib.parse.urlencode((("animal_type", "cat"), ("amount", "1")))
# task: try using "dog" as well

print('http request: url + request + parameters') 
print('1 url:', baseurl)
print('2 request:', request)
print('3 parameters:', parameters)

url = baseurl + request + parameters
print('\nurl:', url)
# https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=1

f = urllib.request.urlopen(url)
answer = json.loads(f.read().decode())
print("response:", answer["text"])
### print(json.dumps(answer, sort_keys=True, indent=4))

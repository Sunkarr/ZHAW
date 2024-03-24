# -*- coding: utf-8 -*-
"""
PROG2 V05-11: network services
"""

#=== Part 1: Protocol (get the data) ===#
import urllib.request

name_of_interest = "Ignazio"

api_endpoint = f"https://api.agify.io?name={name_of_interest}"

f = urllib.request.urlopen(api_endpoint)

data = f.read()
# data contains i.e.:
# b'{"name":"Ignazio","age":68,"count":3949}

#=== Part 2: Format (parse the data) ===#
import json

parsed_data = json.loads(data.decode("utf-8"))
print(f"Presumed age of {name_of_interest}", parsed_data["age"])

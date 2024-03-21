import urllib.request
name = "Ignazio"
api_endpoint = f"https://api.agify.io?name={name}"
f = urllib.request.urlopen(api_endpoint)
data = f.read()
# The data contains for example:
# b'{"name":"Ignazio","age":68,"count":3949}
# Part 2: Format (parse the data)
import json
parsed_data = json.loads(data.decode("utf-8"))
print(f"Presumed age of {name}", parsed_data["age"])
import requests

URL = "https://transport.opendata.ch/v1/connections"
PARAMS = {
    "from": "Zuerich",
    "to": "Bern"
}
HEADERS = {
    "User-Agent": 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
                  'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'
}

response = requests.get(URL, params=PARAMS, headers=HEADERS)
if response.status_code == 200:
    print(response.json())
else:
    print(f"Your request was not successful with error code: {response.status_code}")

# With sleep timer
import time

sleep_time = 1
max_retries = 5
attempts = 0

while attempts < max_retries:
    response = requests.get(URL, params=PARAMS, headers=HEADERS)
    time.sleep(sleep_time)
    sleep_time *= 2  # Double the sleep time
    attempts += 1



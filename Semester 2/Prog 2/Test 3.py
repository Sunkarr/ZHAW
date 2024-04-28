import json
import requests
from datetime import datetime

class TrainConnectionDownloader:
    URL = "https://transport.opendata.ch/v1/connections"

    def __init__(self, start, destination):
        self.start = start
        self.destination = destination

    def fetch_connections(self):
        credentials = f"?from={self.start}&to={self.destination}"
        try:
            response = requests.get(self.URL + credentials)
            response.raise_for_status()  # Raise an exception for non-2xx status codes
            api_content = response.content.decode("utf-8")
            data = json.loads(api_content)
            return data.get('connections', [])
        except requests.exceptions.RequestException as e:
            print(f"Error occurred while fetching data from the API: {e}")
            return []
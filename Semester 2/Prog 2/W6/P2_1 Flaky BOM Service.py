import requests
import time

class BOM:
    def __init__(self):
        self.URL = "http://160.85.252.148/"
        self.log = []
        self.content = []

    def fetch_data(self):
        wait_time = 1
        while True:
            try:
                response = requests.get(self.URL)
                response.raise_for_status()  # Raise an exception for HTTP errors
                content = response.json()
                self.content = content
                return self.content
            except requests.exceptions.RequestException as e:
                self.log.append(f"Error: {e}. Retrying in {wait_time} seconds...")
                time.sleep(wait_time)
                wait_time += 1  # Increase the waiting time

    def print_data(self):
        print(self.content)

    def print_log(self):
        for entry in self.log:
            print(entry)

if __name__ == "__main__":
    bom1 = BOM()
    bom1.fetch_data()
    bom1.print_data()
    bom1.print_log()

import requests
from dataclasses import dataclass
import os
from datetime import datetime, timedelta


@dataclass(frozen=True)
class Downloader:
    URL = ("https://data.stadt-zuerich.ch/dataset/sid_wapo_wetterstationen/download/"
           "messwerte_tiefenbrunnen_seit2007-heute.csv")
    FILENAME = "messwerte_tiefenbrunnen.csv"

    def _new_download(self):
        try:
            response = requests.get(self.URL)
            if response.status_code == 200:
                file_content = response.content
                with open(self.FILENAME, 'wb') as file:
                    file.write(file_content)
                print(f"'{self.FILENAME}' downloaded successfully!")
            else:
                print(f"Failed to download file from '{self.URL}'. Status code: {response.status_code}")
        except Exception as e:
            print(f"An error occurred: {e}")

    def _check_age(self, filepath=FILENAME):
        last_modified_datetime = datetime.fromtimestamp(os.path.getmtime(filepath))
        current_time = datetime.now()
        age = current_time - last_modified_datetime
        return age

    def download(self):
        try:
            age = self._check_age()
            TEN_MINUTES = timedelta(minutes=10)

            if age > TEN_MINUTES:
                self._new_download()
                print(f"'{self.FILENAME}' is now up to date")
            else:
                print(f"'{self.FILENAME}' is already up to date")
        except FileNotFoundError:
            self._new_download()
            print(f"'{self.FILENAME}' is now stored")

if __name__ == "__main__":
    downloader = Downloader()
    downloader.download()

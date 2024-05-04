import requests


def get_coordinates(self):
    url = f"https://nominatim.openstreetmap.org/search?q={self.city_name}&format=json"
    try:
        response = requests.get(url)
        response.raise_for_status()  # Raise an error for non-200 status codes
        data = response.json()
        if data:
            latitude = data[0]['lat']
            longitude = data[0]['lon']
            return latitude, longitude
        else:
            return None, None
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
        return None, None
    except (KeyError, IndexError):
        print("Error: Unable to parse response data")
        return None, None
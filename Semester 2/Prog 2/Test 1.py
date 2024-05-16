import requests

class NoCoordinatesFoundError(Exception):
    """Exception raised when no coordinates are found for the given city and country."""
    pass

def get_coordinates(city_name, country_name):
    """
    Retrieve the latitude and longitude coordinates of a city using the Nominatim OpenStreetMap API.

    Args:
        city_name (str): The name of the city.
        country_name (str): The name of the country.

    Returns:
        tuple: A tuple containing the latitude and longitude coordinates of the city as floats.
               If the city is not found or an error occurs, returns None.
    """
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                             '(KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'}
    url = f"https://nominatim.openstreetmap.org/search?q={city_name},{country_name}&format=json"
    response = requests.get(url, headers=headers)
    if response.status_code == 200 and response.content:
        data = response.json()
        if data:
            latitude = float(data[0]['lat'])
            longitude = float(data[0]['lon'])
            return latitude, longitude
    raise NoCoordinatesFoundError(f"No coordinates found for {city_name}, {country_name}")

if __name__ == "__main__":
    country = "Netherlands"
    city = "Amsterdam Centraal"
    try:
        coordinates = get_coordinates(city, country)
        print(f"Coordinates of {city}, {country}: {coordinates}")
    except NoCoordinatesFoundError as e:
        print(e)

from CityCoordinates import get_coordinates
from dataclasses import dataclass
import math
import pandas as pd


@dataclass
class Calculator:
    __start_city: list = None
    __destination_city: list = None
    __start_city_coordinates: tuple = None
    __destination_city_coordinates: tuple = None
    _df = pd.read_csv('cities.csv')

    def __post_init__(self):
        if self.__start_city:
            coordinates = get_coordinates(self.__start_city[0], self.__start_city[1])
            if coordinates:
                self.__start_city_coordinates = tuple(coordinates)

        if self.__destination_city:
            coordinates = get_coordinates(self.__destination_city[0], self.__destination_city[1])
            if coordinates:
                self.__destination_city_coordinates = tuple(coordinates)

        self._df['Distance'] = self._df.apply(
            lambda row: self.calculate_distance_in_df(row['Latitude'], row['Longitude']), axis=1)

    def set_start_city(self, start_city, start_country):
        self.__start_city = [start_city, start_country]

    def get_start_city(self):
        return self.__start_city

    def set_destination_city(self, destination_city, destination_country):
        self.__destination_city = [destination_city, destination_country]

    def get_destination_city(self):
        return self.__destination_city

    def haversine(self, lon1, lat1, lon2, lat2):
        """
        Calculate the great circle distance between two points
        on the earth (specified in decimal degrees)
        """
        # Convert decimal degrees to radians
        lon1, lat1, lon2, lat2 = map(math.radians, [lon1, lat1, lon2, lat2])

        # Haversine formula
        dlon = lon2 - lon1
        dlat = lat2 - lat1
        a = math.sin(dlat / 2) ** 2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) ** 2
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
        distance = 6371 * c  # Radius of Earth in kilometers
        return distance

    def calculate_distance_in_df(self, latitude_start, longitude_start):
        if self.__destination_city_coordinates:
            if latitude_start and longitude_start:
                lat1, lon1 = latitude_start, longitude_start
            else:
                lat1, lon1 = self.__start_city_coordinates

            lat2, lon2 = self.__destination_city_coordinates

            distance = self.haversine(lon1, lat1, lon2, lat2)

            return distance
        else:
            return None

    def angle_between_points(self, latitude_dest, longitude_dest):
        if self.__start_city_coordinates and self.__destination_city_coordinates:
            lat_start, lon_start = self.__start_city_coordinates
            lat_dest1, lon_dest1 = self.__destination_city_coordinates

        # Calculate distances
        dist_start_dest1 = self.haversine(lon_start, lat_start, lon_dest1, lat_dest1)
        dist_start_dest2 = self.haversine(lon_start, lat_start, longitude_dest, latitude_dest)
        dist_dest1_dest2 = self.haversine(lon_dest1, lat_dest1, longitude_dest, latitude_dest)

        # Use law of cosines to calculate the angle
        cos_angle = (dist_start_dest1 ** 2 + dist_start_dest2 ** 2 - dist_dest1_dest2 ** 2) / (
                    2 * dist_start_dest1 * dist_start_dest2)
        angle_rad = math.acos(cos_angle)
        angle_deg = math.degrees(angle_rad)

        return angle_deg

    def choose_transfer_station(self):
        self._df = self._df.sort_values(by='Distance')

        for row_tuple in self._df.itertuples():
            abs_angle = 0
            while abs_angle < 20:
                latitude = row_tuple.Latitude
                longitude = row_tuple.Longitude
                angle = self.angle_between_points(latitude, longitude)
                abs_angle = abs(angle)
                print(row_tuple.City, abs_angle)
                return row_tuple.City




if __name__ == "__main__":
    calculator = Calculator()
    calculator.set_start_city("Zürich", "Switzerland")
    calculator.set_destination_city("Stuttgart", "Germany")
    calculator.__post_init__()  # Explicitly call post_init after setting cities
    print(calculator.get_start_city())
    print(calculator.get_destination_city())
    print(get_coordinates("Zürich", "Switzerland"))
    print(calculator._df.sort_values(by='Distance'))

    print(calculator.choose_transfer_station())

"""
Prog 1
W10
G5 Trail Hunt–RanglisteStudiengänge
Author: Jonas Bratschi (bratsjon)
Date: 29.11.2023
"""

"""Disclaimer:
I have seen other students gpx-files have another data structure, which my code can't read properly.
But my code works at least for the data structure in the files 'bratsjon.gpx' and selesaro.gpx'.
These files are exported from Strava respectively Garmin which are well known and widespread fitnesstrackers."""

import gpxpy
import math
from datetime import datetime


def haversine(lat1, lon1, lat2, lon2):
    # distance between latitudes and longitudes
    dLat = (lat2 - lat1) * math.pi / 180.0
    dLon = (lon2 - lon1) * math.pi / 180.0

    # convert to radians
    lat1 = (lat1) * math.pi / 180.0
    lat2 = (lat2) * math.pi / 180.0

    # apply formulae
    a = (pow(math.sin(dLat / 2), 2) +
         pow(math.sin(dLon / 2), 2) *
         math.cos(lat1) * math.cos(lat2))
    rad = 6371
    c = 2 * math.asin(math.sqrt(a))
    return rad * c


def parse_time_line(line):
    try:
        # Extract time stamp from a line containing either "<time>" or "<time>" within "<trkpt>"
        time_format = "%Y-%m-%dT%H:%M:%S.%fZ"

        # Check if the line contains "<trkpt>" and "<time>"
        if ("<trkpt" in line or "<rtept" in line) and "<time>" in line:
            root = ET.fromstring(line)
            time_element = root.find(".//time")
            if time_element is not None:
                time_str = time_element.text.strip()
                return datetime.strptime(time_str, time_format)

        # If not, assume the line contains only "<time>"
        time_str = line.strip().replace("<time>", "").replace("</time>", "")
        return datetime.strptime(time_str, time_format)
    except:
        # Extract time stamp from a line starting with "<time>"
        time_format = "%Y-%m-%dT%H:%M:%S%z"
        time_str = line.strip().replace("<time>", "").replace("</time>", "")
        return datetime.strptime(time_str, time_format)




def calculate_statistics(elevation_points, trail_points, time_points):
    if len(time_points) < 2:
        print("Insufficient data to calculate statistics.")
        return  # Avoiding division by zero or index out of range

    elevation_delta = max_elevation = min_elevation = elevation_points[0]
    total_distance = 0
    max_speed = 0
    total_speed = 0
    num_speed_points = 0

    for i, point in enumerate(trail_points[:-1]):
        lat1, lon1 = point
        lat2, lon2 = trail_points[i + 1]

        # Calculate distance using haversine formula
        distance = haversine(lat1, lon1, lat2, lon2)

        # Calculate elevation delta
        elevation_delta = max(elevation_delta, abs(elevation_points[i + 1] - elevation_points[i]))

        # Update total distance
        total_distance += distance

        # Calculate speed
        time_delta = (time_points[i + 1] - time_points[i]).total_seconds()

        if time_delta > 0:
            speed = distance / time_delta * 1000 * 3.6
            total_speed += speed
            max_speed = max(max_speed, speed)
            num_speed_points += 1

    # Calculate average speed over the entire GPX file
    average_speed = total_speed / num_speed_points if num_speed_points > 0 else 0

    # Calculate total time
    total_time = (time_points[-1] - time_points[0]).total_seconds() / 3600

    return elevation_delta, max_speed, average_speed, total_time, total_distance


def trail_hunt(FILE_NAME):
    try:
        with open(FILE_NAME, 'r') as gpx_file:
            gpx = gpxpy.parse(gpx_file)

            # Extract elevation, trail points, and time points simultaneously
            elevation_points = [point.elevation for track in gpx.tracks for segment in track.segments for point in
                                segment.points]
            trail_points = [(point.latitude, point.longitude) for track in gpx.tracks for segment in track.segments for
                            point in segment.points]
            time_points = [parse_time_line(point.time.isoformat()) for track in gpx.tracks for segment in track.segments
                           for point in segment.points]

    except IOError:
        print("Datei kann nicht verarbeitet werden: " + FILE_NAME)
    else:
        return calculate_statistics(elevation_points, trail_points, time_points)

"""        print('Elevation Delta:', elevation_delta, 'meters')
        print('Max Speed:', max_speed * 3.6 * 1000, 'km/h')
        print('Average Speed:', average_speed * 3.6 * 1000, 'km/h')
        print('Total Time:', total_time / 3600, 'hours')
        print('Total Distance:', total_distance, 'km')"""

"""FILE_NAME = "./bratsjon.gpx"
print(trail_hunt(FILE_NAME))"""
import gpxpy
import gpxpy.gpx
from datetime import datetime


def parse_time_line(line):
    # Extract time stamp from a line starting with "<time>"
    time_format = "%Y-%m-%dT%H:%M:%SZ"
    time_str = line.strip().replace("<time>", "").replace("</time>", "")
    return datetime.strptime(time_str, time_format)


def extract_data_from_gpx(gpx):
    elevation_points = []
    trail_points = []
    time_points = []

    for track in gpx.tracks:
        for segment in track.segments:
            for point in segment.points:
                elevation_points.append(point.elevation)
                trail_points.append((point.latitude, point.longitude))
                time_points.append(point.time)

    return elevation_points, trail_points, time_points


def trail_hunt(FILE_NAME):
    try:
        with open(FILE_NAME, 'r') as gpx_file:
            gpx = gpxpy.parse(gpx_file)

            if gpx.version == "1.0":
                # Extract elevation, trail points, and time points simultaneously
                elevation_points, trail_points, time_points = extract_data_from_gpx(gpx)
            elif gpx.version == "1.1":
                # Extract elevation, trail points, and time points simultaneously
                elevation_points, trail_points, time_points = extract_data_from_gpx(gpx)
            else:
                print("Unsupported GPX version:", gpx.version)
                return None

    except IOError:
        print("Datei kann nicht verarbeitet werden: " + FILE_NAME)
        return None

    return calculate_statistics(elevation_points, trail_points, time_points)


# Rest of your code remains unchanged

# Example usage:
file_names = ["path/to/gpx/file1.gpx", "path/to/gpx/file2.gpx", "path/to/gpx/file3.gpx"]

for file_name in file_names:
    result = trail_hunt(file_name)
    if result:
        print(f"Statistics for file {file_name}:")
        print("Elevation Delta:", result[0])
        print("Max Speed:", result[1])
        print("Average Speed:", result[2])
        print("Total Time:", result[3])
        print("Total Distance:", result[4])
        print("\n")


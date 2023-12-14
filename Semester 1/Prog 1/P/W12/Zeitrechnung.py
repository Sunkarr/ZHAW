from datetime import time

filepath = "./times.txt"

total_minutes = 0  # Initialize total minutes

with open(filepath, 'r') as log:
    for line in log:
        datum = line.split(";")
        zeit = datum[1].split("-")
        begin = zeit[0].split(":")
        end = zeit[1].split(":")
        end = [end[0], end[1].replace("\n", "")]
        begin_time = time(int(begin[0]), int(begin[1]), 0, 0)
        end_time = time(int(end[0]), int(end[1]), 0, 0)

        delta = (end_time.hour - begin_time.hour) * 60 + (end_time.minute - begin_time.minute)
        total_minutes += delta

print(f"Total working time in minutes: {total_minutes}")

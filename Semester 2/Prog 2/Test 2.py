

class TrainConnectionMenu:
    def __init__(self, connections):
        self.connections = connections

    def display_next_connection(self):
        # Convert departure timestamps to datetime objects
        for conn in self.connections:
            try:
                conn['from']['departureTimestamp'] = datetime.fromtimestamp(conn['from']['departureTimestamp'])
            except KeyError:
                print(f"Invalid connection data: 'from.departureTimestamp' key not found for connection: {conn}")
                continue

        # Sort connections by departure time
        sorted_connections = sorted(self.connections, key=lambda x: x['from']['departureTimestamp'])

        # Print the next connection
        if sorted_connections:
            next_conn = sorted_connections[0]
            for section in next_conn['sections']:
                try:
                    departure_timestamp = section['departure']['departureTimestamp']
                    if isinstance(departure_timestamp, int):
                        departure_time = datetime.fromtimestamp(departure_timestamp).strftime('%H:%M')
                    else:
                        departure_time = departure_timestamp.strftime('%H:%M')
                except (KeyError, AttributeError):
                    print(f"Invalid section data: 'departure.departureTimestamp' key not found or invalid for section: {section}")
                    continue

                station_name = section['departure']['station']['name']
                platform = section['departure']['platform'] or '-'

                if 'journey' in section and section['journey']:
                    journey_name = section['journey']['name']
                    print(f"{departure_time} {station_name:<20}{platform}")
                    print(f"             {journey_name}")
                else:
                    arrival_time = section['arrival']['arrivalTimestamp'].strftime('%H:%M')
                    arrival_delay = section['arrival']['delay'] if 'delay' in section['arrival'] and section['arrival']['delay'] else ''
                    print(f"{departure_time} {station_name:<20}{platform}")
                    print(f"{arrival_time} +{arrival_delay} {section['arrival']['station']['name']}")
        else:
            print("No connections found")

if __name__ == "__main__":
    start = "Männedorf"
    destination = "Bern"

    downloader = TrainConnectionDownloader(start, destination)
    connections = downloader.fetch_connections()

    menu = TrainConnectionMenu(connections)
    menu.display_next_connection()

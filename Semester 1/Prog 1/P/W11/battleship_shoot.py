def battleship_shoot_check_log(x, y):
    user = "bratsjon"
    shot = [x, y]
    file_name = './log.txt'
    past_shots = []

    from datetime import datetime
    # Get the current timestamp
    timestamp = datetime.now()

    with open(file_name, 'r') as past_log:
        for line in past_log:
            # Split the line into a list using '/' as a separator
            elements = line.strip().split('/')

            # Check if the elements list has enough items and 'shot' is present
            if len(elements) >= 3 and 'shot' in elements[2] and elements[1] == user:
                # Extract the shot coordinates and convert them to integers
                past_shot = [int(s) for s in elements[2][6:-1].split(",")]
                past_shots.append(past_shot)

    if shot in past_shots:
        print("This shot has already been fired")
    else:
        with open(file_name, 'a') as log:
            log.write(f"{timestamp}/{user}/shot:{shot}\n")
            print("Shot fired on", x, "/", y)

battleship_shoot_check_log(9, 10)

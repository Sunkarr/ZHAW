import ev3dev2.sound

# Initialize the sound and note objects
sound = ev3dev2.sound.Sound()

while True:
    # Ask for a note input
    note = input("Enter a note (e.g., 'C4') or 'q' to quit: ")

    # Check if the input is 'q' to quit
    if note.lower() == 'q':
        break

    # Play the note repeatedly
    sound.play_note(note)

# Cleanup
sound.stop()

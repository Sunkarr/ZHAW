from dataclasses import dataclass

@dataclass
class Fish:
    legs: int = 0
    predator: bool = False
    venomous: bool = False

@dataclass
class Stingray(Fish):
    venomous: bool = True

@dataclass
class Dogfish(Fish):
    venomous: bool = False

@dataclass
class Haddock(Fish):
    predator: bool = False

# Instanzierung der Tiere
stingray = Stingray()
dogfish = Dogfish()
haddock = Haddock()

# Test der Instanzen
print(f"Stingray: legs={stingray.legs}, predator={stingray.predator}, venomous={stingray.venomous}")
print(f"Dogfish: legs={dogfish.legs}, predator={dogfish.predator}, venomous={dogfish.venomous}")
print(f"Haddock: legs={haddock.legs}, predator={haddock.predator}, venomous={haddock.venomous}")
from dataclasses import dataclass, field

@dataclass
class Fish:
    name: str = field(init=False)
    legs: int = 0
    predator: bool = False
    venomous: bool = False

@dataclass
class Stingray(Fish):
    name: str = "Stingray"
    predator: bool = True
    venomous: bool = True

@dataclass
class Dogfish(Fish):
    name: str = "Dogfish"
    predator: bool = True
    venomous: bool = False

@dataclass
class Haddock(Fish):
    name: str = "Haddock"
    predator: bool = False
    venomous: bool = False

# Testinstanzen erstellen
stingray = Stingray()
dogfish = Dogfish()
haddock = Haddock()

# Testausgabe
print(stingray)
print(dogfish)
print(haddock)

from dataclasses import dataclass

@dataclass (frozen=True)
class Knight:
    hp: int = 125
    damage: int = 100

    def walk(self):
        print("+1")

if __name__ == "__main__":
    knight = Knight()
    knight.walk()
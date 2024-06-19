class Player:
    def __init__(self):
        self.hp = 100

    def walk(self):
        print(f"{self} läufft")


class Archer(Player):
    def __init__(self, arrows):
        super().__init__()
        self.damage = 5
        self._arrows = arrows #"privates" Attribut

    def __str__(self):
        # Kurzbeschrieb der Klasse, taucht auf bei print('Klasse')
        return f"Bogenschütze mit {self._arrows} Pfeilen"

    def __repr__(self):
        # Beschrieb für Developer, ersetzt __str__ falls dieser nicht exisitert
        return f"Archer ({self.hp}, {self.damage}, {self._arrows})"

    def shoot(self):
        self._arrows -= 1
        print(f"Bogenschütze hat geschossen und hat noch {self._arrows} Pfeile")


    @staticmethod
    def shout():
        print("I am a staticmethod and need no external parameters")

if __name__ == "__main__":
    archer = Archer(5)
    print(archer)
    print(repr(archer))
    archer.shoot()
    archer.walk()





from dataclasses import dataclass
import pydantic

@dataclass(frozen=True)
class Bogen:
    name: str
    preis: int
    schaden: int = 100

bogen1 = Bogen("Feuerbogen", 2500, 35)

print(bogen1)
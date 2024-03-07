class Wallet:
    def __init__(self, name, contains):
        self.__name = name
        self.__value = self.calculate_total_value(contains)

    def calculate_total_value(self, money_objects):
        total_value = 0
        for money_object in money_objects:
            total_value += money_object.get_value()
        return total_value

    def __repr__(self):
        result = f"{self.__name}, {self.__value}"
        return result

class Money:
    def __init__(self, value):
        self.__monetaryvalue = value

class Coin(Money):
    def __init__(self, value):
        Money.__init__(self, value)
        self.value = value
    def get_value(self):
        return self.value

class Banknote(Money):
    def __init__(self, value):
        Money.__init__(self, value)
        self.value = value
    def get_value(self):
        return self.value

coin_1 = Coin(1)
banknote_100 = Banknote(100)
mein_geld = coin_1, banknote_100
wallet_1 = Wallet("Wallet 1", mein_geld)

print(wallet_1)

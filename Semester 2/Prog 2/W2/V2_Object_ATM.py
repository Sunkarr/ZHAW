class Atm:
    def __init__(self, saldo = 0):
        self.__saldo = saldo

    def withdraw(self, amount):
        if self.__saldo >= amount:
            self.__saldo -= amount
            print(f"New saldo within {self} = {self.__saldo}")
        else:
            print(f"Amount ({amount}) which you want to withdraw exceeds {self} saldo ({self.__saldo})")


atm_1 = Atm(3000)
atm_1.withdraw(2000)

print(dir(Atm))
class Person:
    def __init__(self, name = "", age = 0):
        self.__name = name
        self.__age = age # Underline sagt: Variable ist privat -> sozusagen schreibgeschützt

    def __repr__(self):
        result = f"{self.__name}, {self.__age}"
        return result

    def set_name(self, new_name: str):
        self.__name = new_name

    def set_age(self, new_age: int):
        self.__age = new_age

    def get_attributes(self):
        return self.__name, self.__age

persons = Person("Jonas", 25)
persons.set_name("Max")
persons.set_age(46)
print(persons)
print(persons.get_attributes())
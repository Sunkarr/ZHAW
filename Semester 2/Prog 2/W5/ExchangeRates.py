import json
import urllib.request
from dataclasses import dataclass


@dataclass(frozen=True)
class ExchangeRates:
    """
    A class to retrieve and convert exchange rates using the Open Exchange Rates API.

    Attributes:
        id_jonas (str): The unique API ID for Open Exchange Rates.
        url (str): The URL to fetch the latest exchange rates.
        rates (dict): The dictionary of exchange rates fetched from the API.

    Methods:
        get_usd_chf(): Returns the exchange rate for converting USD to CHF.
        get_chf_usd(): Returns the exchange rate for converting CHF to USD.
        get_usd_eur(): Returns the exchange rate for converting USD to EUR.
        get_eur_usd(): Returns the exchange rate for converting EUR to USD.
        get_chf_eur(): Returns the exchange rate for converting CHF to EUR.
        get_eur_chf(): Returns the exchange rate for converting EUR to CHF.
    """

    id_jonas = "01c82161cc934ff8b87355f0a22ded53"
    try:
        url = f"https://openexchangerates.org/api/latest.json?app_id={id_jonas}"
        f = urllib.request.urlopen(url)
        api_daten = json.load(f)
        rates = api_daten['rates']
    except:
        raise ValueError("Data not fetchable")

    def get_usd_chf(self, amount=1):
        result = self.rates['CHF'] * amount
        return result

    def get_chf_usd(self, amount=1):
        result = 1/self.rates['CHF'] * amount
        return result

    def get_usd_eur(self, amount=1):
        result = self.rates['EUR'] * amount
        return result

    def get_eur_usd(self, amount=1):
        result = 1/self.rates['EUR'] * amount
        return result

    def get_chf_eur(self, amount=1):
        result = self.get_chf_usd() * self.get_usd_eur() * amount
        return result

    def get_eur_chf(self, amount=1):
        result = self.get_eur_usd() * self.get_usd_chf() * amount
        return result


if __name__ == "__main__":
    exchange_rates = ExchangeRates()
    print(exchange_rates.get_usd_chf())
    print(exchange_rates.get_chf_usd())
    print(exchange_rates.get_usd_eur())
    print(exchange_rates.get_eur_usd())
    print(exchange_rates.get_chf_eur())
    print(exchange_rates.get_eur_chf())

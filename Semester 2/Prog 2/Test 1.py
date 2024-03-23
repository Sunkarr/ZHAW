import requests

# API endpoint
url = "https://api.exchangeratesapi.io/latest"

# Parameters for the API request
params = {
    "base": "EUR",  # Base currency
    "symbols": "CHF,USD"  # Currencies to get rates for
}

# Send the GET request
response = requests.get(url, params=params)

# Check if the request was successful
if response.status_code == 200:
    # Get the exchange rates from the response
    rates = response.json()["rates"]

    # Extract the desired pairs
    chf_eur = rates["CHF"]
    usd_eur = rates["USD"]
    chf_usd = chf_eur / usd_eur

    # Print the pairs
    print(f"CHF/EUR: {chf_eur}")
    print(f"USD/EUR: {usd_eur}")
    print(f"CHF/USD: {chf_usd}")
else:
    print(f"Error: {response.status_code}")
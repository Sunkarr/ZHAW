import urllib.request

def geheimcode():
    url = "http://160.85.252.148:12347/secret3875"

    req = urllib.request.Request(url)
    with urllib.request.urlopen(req) as response:
        secret_word = response.read().decode('utf-8')
    return secret_word

print(geheimcode())
import pandas as pd
from IPython.display import display



"""verkaeuffe = {"aepfel" : {"Heute": 2, "Gestern": 4}, "birnen" : {"Heute": 4, "Gestern": 5}}
df_verkäuffe = pd.DataFrame(verkaeuffe)
print(df_verkäuffe)"""


"""df = pd.DataFrame({"Apfel": [14, 16, 10], "Birne": [15, 18, 19]})
print(df.Apfel)
print(df["Apfel"])"""

df = pd.DataFrame({
    "Banane": [12, 14, 12], "Apfel" : [14, 16, 10],
    "Birne" : [15, 18, 19], "Orange": [18, 21, 22]
})
display(df)
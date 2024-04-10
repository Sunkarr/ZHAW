## Pandas

# Merge two dataframes on different named columns
df_output = pd.merge(imdb, df_dream_american, left_on='id', right_on='Movie_IDs', how='inner')

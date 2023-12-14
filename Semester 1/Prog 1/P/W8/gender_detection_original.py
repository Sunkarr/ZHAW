"""
Prog 1
W08
P04, Aufgabe 2.2 Gender Detection in Text (selective: AV DS)
Author: Jonas Bratschi (bratsjon)
Date: 11.11.2023
"""

def separate_and_lower(textinput: str) -> list:
    textinput = textinput.lower()
    textinput = textinput.replace(".", " .")
    textinput = textinput.replace("?", " ?")
    textinput = textinput.replace("!", " !")
    textinput = textinput.replace(",", " ,")
    words_and_sentence_marks = textinput.split(" ")
    return(words_and_sentence_marks)

def count_singular_pronouns(textinput: str) -> int:
    words = separate_and_lower(textinput)
    count = 0
    pronouns = ["i", "me", "my"]
    for word in words:
        if word in pronouns:
            count += 1
    return(count)

def document_length(textinput: str) -> int:
    words = separate_and_lower(textinput)
    count = 0
    no_go_words = [".", ",", "!", "?",]
    for word in words:
        if word not in no_go_words:
            count += 1
    return(count)

def words_per_sentence(textinput: str) -> int:
    words = separate_and_lower(textinput)
    count_sentences = 0
    count_words = 0
    sentence_split = [".", "!", "?"]
    # number of sentences
    for word in words:
        if word not in sentence_split:
            count_sentences += 1
    # number of words
    for word in words:
        if word in sentence_split:
            count_words += 1
    # calculates the average
    average = count_sentences / count_words
    return(average)



"""usertext = input("Enter a text: ")
print('Quantity of the words "I", "me" or "my":', count_singular_pronouns(usertext))
print("Text length in words:", document_length(usertext))
print("Average words per sentence: ", words_per_sentence(usertext))"""



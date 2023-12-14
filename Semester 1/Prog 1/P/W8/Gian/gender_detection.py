


def count_singular_pronouns(text:str) -> int:
    sing_pron1 = text.count("I ")
    print(sing_pron1)
    sing_pron2 = text.count(" me ")
    print(sing_pron2)
    sing_pron3 = text.count(" my ")
    print(sing_pron3)
    singular_pronouns = sing_pron1 + sing_pron2 + sing_pron3
    return singular_pronouns


def document_length(text:str) -> int:
    word_list = text.split(" ")
    num_of_words = len(word_list)
    return num_of_words


def words_per_sentence(text:str) -> int:
    sentance_list = text.split(". ")
    print(len(sentance_list))
    num_of_sentence = len(sentance_list)
    word_list = text.split(" ")
    num_of_words = len(word_list)
    avg_words_sentence = num_of_words / num_of_sentence
    return avg_words_sentence

"""tex = input()


print(count_singular_pronouns(tex))
print(words_per_sentence(tex))
print(document_length(tex))"""
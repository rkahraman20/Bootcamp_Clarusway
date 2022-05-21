# Assignment_3_Negative_Meaning
# This function takes a word and returns in negative meaning by adding "not" to the front.
# However, if the word already begins with "not", returns the string unchanged.

def not_string(word):
    if word.startswith('not'):
        return word
    else:
        return "not " + word

print(not_string('sugar'))
print(not_string('y'))
print(not_string('not bad'))
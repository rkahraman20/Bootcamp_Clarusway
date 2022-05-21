# Assignment_6_Front_Back_Char
# This function takes a string and returns a new string where the first and last characters of the entered string have been exchanged.

def front_back(word):
    if len(word) != 1:
        word = word[-1] + word[1:-1] + word[0]
    return word

word = input("Please enter any string: ")
print(front_back(word))
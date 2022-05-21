# Assignment_11_Letter Frequency
# Finds the frequency of any letter in a user-entered sentence.

user_input1 = input("Please input a sentence: ")
user_input2 = input("Please input a letter to learn its frequency: ")
print(f"{user_input2}'s frequency is", int(user_input1.lower().count(user_input2.lower())/len(user_input1)*100))
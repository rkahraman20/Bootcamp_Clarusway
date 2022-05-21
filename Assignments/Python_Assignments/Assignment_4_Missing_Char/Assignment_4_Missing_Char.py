# Assignment_4_Missing_Char
# This function takes a string and an integer n and returns a new string where the character at index n has been removed.
# The value of n will be a valid index of a character in the original string (i.e. n will be in the range 0....len(str)-1 inclusive).

def missing_char(word, n):
    return word[0:n] + word[n + 1 :]

my_str = input("Please enter any string: ")
my_int = int(input("Please enter an integer lower than the length of your string: "))
while my_int >= len(my_str):
    print()
    print("You entered a wrong integer!")
    print()
    my_int = int(input("Please enter an integer lower than the length of your string: "))

print(missing_char(my_str, my_int))
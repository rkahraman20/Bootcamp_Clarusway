# Assignment_2_Parrot_Trouble
# We have a loud talking parrot. We are in trouble if the parrot is talking and the hour is before 6 or after 21.
# This function takes two parameters (talking and hour) to return True if we are in trouble with parrot.
# The argument to "talking" parameter can only be True or False whether the parrot is talking or not.
# The argument to "hour" parameter should be the clock time between 0 to 23.

def parrot_trouble(talking, hour):
    if (hour < 6 or hour > 21) and talking == True:
        return True
    else:
        return False

print(parrot_trouble(True, 5))
print(parrot_trouble(True, 8))
print(parrot_trouble(False, 22))
print(parrot_trouble(True, 23))
# Assignment_1_Doubler
# Returns the sum of two given integer values.
# If values are the same, returns the double of their sum.

def sum_double(x, y):
    if x == y:
        return (x + y) * 2
    else:
        return x + y

print(sum_double(1, 2))
print(sum_double(4, 7))
print(sum_double(6, 6))
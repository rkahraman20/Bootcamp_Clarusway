# Assignment_7_Find_Minimum
# This function finds the minimum value in any group of numbers and prints out.

def my_min(*numbers):
    num = list(numbers)
    for i in range(0, len(num) - 1):
        for j in range(i + 1, len(num)):
            if num[i] > num[j]:
                a = num[i]
                num[i] = num[j]
                num[j] = a
    return num[0]

print(my_min(3,8,-9,0,12,1.2))
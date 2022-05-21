# Assignment_10_Most_Frequent_Element
# This function returns the most frequent (repeating) element.

def most_freq(given_list):
    num = list()
    for i in range(len(given_list)):
        k = 0
        for j in range(len(given_list)):
            if given_list[i] == given_list[j]:
                k += 1
        num.append(k)
        ind = num.index(max(num))
    return given_list[ind]

print(most_freq([1,2,3,3,3,3,4,4,5,5]))
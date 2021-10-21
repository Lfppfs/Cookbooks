import random

random.seed(1)
array_to_search = random.choices(range(0, 100), k=11)
array_to_search.sort()
array_to_search


def linear_search(target, array=array_to_search):
    for i in range(len(array)):
        if array[i] == target:
            return f'{target} is in position {i}'
    return f'{target} is not in array'


linear_search(2)
linear_search(13)
linear_search(44)
linear_search(1)
linear_search(51)


def binary_search(target, array):
    while len(array) > 0:
        middle_point = len(array) - 1 / 2
        if(array[int(middle_point)] == target):
            return f"{target} is in array"
        elif(array[int(middle_point)] < abs(target)):
            array = array[int(middle_point) + 1:len(array)]
        elif(array[int(middle_point)] > abs(target)):
            array = array[0:int(middle_point)]
    return f"{target} is not in the array"


binary_search(2, array_to_search)
binary_search(9, array_to_search)
binary_search(44, array_to_search)
binary_search(65, array_to_search)
binary_search(78, array_to_search)
binary_search(1, array_to_search)
binary_search(7, array_to_search)
binary_search(64, array_to_search)
binary_search(81, array_to_search)


def selection_sort(array_target):
    array = array_target.copy()
    print(f"initial array = {array}\n")
    for i in range(0, len(array)):
        print(f"unsorted array = {array[i + 1:len(array)]}")
        unsorted_elements = array[i:len(array)]
        minimum = min(unsorted_elements)
        array[array.index(minimum)] = array[i]
        array[i] = minimum
        print(f"new array = {array[i]}")
    return array


array_to_search = [5, 2, 1, 3, 6, 4]  # this one works
array_to_search = [1, 2, 1, 3, 6, 4]  # this breaks because
# when i tell python to put 2 in place of the minimum
# value, it puts 2 in place of the 1st number 1, not in place of
# the 2nd number 1
# that is, the function breaks because there are two equal values
array_to_search = [5, 2, 1, 3, 11, 6, -10]  # this one works

selection_sort(array_to_search)

# i got the block below from some site
# this one works even if the array has repeated entries
A = [64, 25, 12, 12, 22, 11]
for i in range(len(A)):
    # Find the minimum element in remaining
    # unsorted array
    min_idx = i
    for j in range(i + 1, len(A)):
        if A[min_idx] > A[j]:
            min_idx = j
    # Swap the found minimum element with
    # the first element
    A[i], A[min_idx] = A[min_idx], A[i]
for i in range(len(A)):
    print("%d" % A[i]),


def bubble_sort(array_target):
    array = array_target.copy()
    counter = -1
    while counter != 0:
        counter = 0
        for i in range(1, len(array)):
            if array[i - 1] > array[i]:
                counter += 1
                # minimum = array[i]
                # array[i] = array[i - 1]
                # array[i - 1] = minimum
                # this line does the same as the three lines above
                array[i], array[i - 1] = array[i - 1], array[i]
    return(array)


array_to_search = [5, 2, 1, 3, 6, 4]  # this one works
array_to_search = [1, 2, 1, 3, 6, 4]  # this one also works
array_to_search = [5, 2, 1, 3, 11, 6, -10]  # this one also
bubble_sort(array_to_search)

#####################################################
#####################################################
#####################################################
#####################################################


def insertion_sort(array_target):
    array = array_target.copy()
    # print(array)
    for i in range(1, len(array)):
        for j in range(1, i + 1):
            print(
                f'''array[j] = {array[j]}, array[j - 1] = {array[j - 1]}, i = {i}, j = {j}''')
            if array[j] < array[j - 1]:
                minimum = array[j]
                array[j] = array[j - 1]
                array[j - 1] = minimum
                print(
                    f'''new array[j] = {array[j]}, new array[j - 1] = {array[j - 1]}, i = {i}, j = {j}''')

        #         print(array)
        # print(array[i])
    return(array)


array_to_search = [1, 2, 1, 3, 6, 4]  # this one works
array_to_search = [5, 2, 1, 3, 6, 4]  # this one breaks
array_to_search = [11, -10]  # this one works
array_to_search = [11, 6, -10]  # this one breaks
insertion_sort(array_to_search)


def insertion_sort(array_target):
    array = array_target.copy()
    print(array)
    for i in range(0, len(array)):
        counter = 1
        while counter != 0:
            if array[counter] < array[counter - 1]:
                print(counter)
                minimum = array[counter]
                array[counter] = array[counter - 1]
                array[counter - 1] = minimum
                print(array)
                counter += 1
            else:
                counter = 0
    return(array)


insertion_sort(array_to_search)

array_to_search = [1, 2, 1, 3, 6, 4]  # this one works
array_to_search = [5, 2, 1, 3, 6, 4]  # this one breaks
array_to_search = [11, -10]  # this one works
array_to_search = [11, 6, -10]  # this one breaks

array_to_search = [11, 6, -10]

key = array_to_search[2]
if key < array_to_search[1]:
    array_to_search[2] = array_to_search[1]
if key < array_to_search[0]:
    array_to_search[1] = array_to_search[0]
    array_to_search[0] = key

key = array_to_search[2]
if key < array_to_search[1]:
    array_to_search[2] = array_to_search[1]
    array_to_search[1] = key

array_to_search = [11, 6, -10]

for i in range(1, -1, -1):
    print(i)

for i in range(1, -1, -1):
    key = array_to_search[2]
    if key < array_to_search[1]:
        array_to_search[2] = array_to_search[1]
    if key < array_to_search[0]:
        array_to_search[1] = array_to_search[0]
        array_to_search[0] = key
    if i == 0:
        # key = array_to_search[2]
        if key < array_to_search[1]:
            array_to_search[2] = array_to_search[1]
            array_to_search[1] = key
array_to_search

array_to_search = [11, 6, -10]
for i in range(1, -1, -1):
    key = array_to_search[i + 1]

    for j in range(1, -1, -1):
        if key < array_to_search[j]:
            array_to_search[j + 1] = array_to_search[j]
            if j == 0:
                array_to_search[0] = key
    # if i == 0:
    #     # key = array_to_search[2]
    #     if key < array_to_search[1]:
    #         array_to_search[2] = array_to_search[1]
    #         array_to_search[1] = key
array_to_search


array_to_search = [11, 6, -10]
key = array_to_search[2]
for j in range(1, -1, -1):
    if key < array_to_search[j]:
        array_to_search[j + 1] = array_to_search[j]
        if j == 0:
            array_to_search[0] = key
array_to_search

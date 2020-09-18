# list comprehension
# more readable than a default for loop
list_comp = [x * x for x in range(1, 11)]
print(list_comp)

# conditional statements can be used in comprehensions
list_comp = [x * x for x in range(1, 11) if x * x % 2 == 0]

# dictionary comprehension
# if one has 2 lists, one can match each element using a dictionary comprehension and zip
days = ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
subjects = ('Physics', 'Biology', 'Chemistry', 'Maths', 'CompScience')

days_week = {day: subject for day, subject in zip(days, subjects)}
days_week

# same as:
# days_week = {}
# for days, subject in zip(days, subjects):
#     days_week[days] = subject
# days_week

# matching every element of a list with every element of another list
list_a = [1, 2, 3, 4, 5]
list_b = ['a', 'b', 'c', 'd', 'e']

list_c = [(num, letter) for letter in list_a for num in list_b]
print(list_c)


def multiply2(x):
    return x * 2


# map iterates a function
list(map(multiply2, [1, 2, 3, 4]))

# same as above but using lambda
list(map(lambda x: x * 2, [1, 2, 3, 4]))

# same as above but using list comprehension (more readable)
list_test = [x * 2 for x in [1, 2, 3, 4]]
list_test

# some ways of getting values from a dictionary using map and lambda
some_dict = [{'name': 'python', 'points': 10}, {'name': 'java', 'points': 8}]
list(map(lambda x: x['name'], some_dict))  # Output: ['python', 'java']
list(map(lambda x: x['points'] * 10,  some_dict))  # Output: [100, 80]
list(map(lambda x: x['name'] == "python", some_dict))  # Output: [True, False]

# filter is similar to map, but only applies the function to True values of a boolean statement
some_list = [1, 2, 3, 4, 5, 6]
list(filter(lambda x: x % 2 == 0, some_list))

# zip takes n number of iterables and returns list of tuples
# ith element of the tuple is created using the ith element from each of the iterables
list_a = [1, 2, 3, 4, 5]
list_b = ['a', 'b', 'c', 'd', 'e']

zipped_list = list(zip(list_a, list_b))

print(zipped_list)

# unequal lengths of zipped lists
list1, list2 = [1, 2, 3, 6, 7, 8, 9], [4, 5, 6]
for i, j in zip(list1, list2):
    print(i, j)

# To unzip a list of tuples use zip(*list_of_tuples)
zipper_list = [(1, 'a'), (2, 'b'), (3, 'c')]
list_a, list_b = zip(*zipper_list)
print(list_a)
print(list_b)

list_a = [1, 2, 3]
list_b = [4, 5, 6]
zipped = zip(list_a, list_b)  # Output: Zip Object. <zip at 0x4c10a30>
# len(zipped) # TypeError: object of type 'zip' has no len()
# zipped[0] # TypeError: 'zip' object is not subscriptable
# list_c = list(zipped) #Output: [(1, 4), (2, 5), (3, 6)]
# list_d = list(zipped) # Output is empty list because the above statement exhausted the zipped object

# list comprehension
# more readable than a default for loop
list_comp = [x * x for x in range(1, 11)]
list_comp

# conditional statements can be used in comprehensions
list_comp = [x * x for x in range(1, 11) if x * x % 2 == 0]
list_comp

# dictionary comprehension

# map
# iterates a function


def multiply2(x):
    return x * 2


map(multiply2, [1, 2, 3, 4])


# filter

# script for calculating factorials
def factorial_rec(n):
    # using recursion
    if n <= 1:
        return 1
    else:
        n = n * factorial_rec(n - 1)
    return n


n = 5
result = factorial_rec(n)
print('factorial_final_result:', result, '\n')

print('recursion_series:')
for i in range(n + 1):
    print("the factorial of", i, "is", factorial_rec(i))


def factorial_loop(n):
    # using loop
    print('factorial_loop:')
    factorial = 1
    for i in range(0, n + 1):
        if i <= 1:
            print("the factorial of", i, "is", factorial)
        else:
            factorial = factorial * (i)
            print("the factorial of", i, "is", factorial)
    return factorial


factorial_loop(n)

import time

# from here: https://www.python-course.eu/python3_memoization.php


def memoize(f):
    memo = {}

    def helper(x):
        if x not in memo:
            memo[x] = f(x)
        return memo[x]
    return helper


@memoize  # memoize is decorating fib, see link above for details
def fib(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib(n - 1) + fib(n - 2)


time1 = time.perf_counter()
for i in range(100000):
    fib(100)
time2 = time.perf_counter()
print(f'result = ', time2 - time1)

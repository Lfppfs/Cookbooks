# script for calculating fibonacci sequence
def fibonacci_rec(n):
    # using recursion
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        f_n = fibonacci_rec(n - 1) + fibonacci_rec(n - 2)
    return f_n


n = 10
result = fibonacci_rec(n)
print('recursion_final_result:', result, '\n')

print('recursion_series:')
for i in range(0, n):
    print(fibonacci_rec(i))


def fibonacci_loop(n):
    # using loops
    print('loop_series:')
    f_n_minus_2 = 0
    f_n_minus_1 = 1
    if n == 0:
        return 0
    elif n == 1 or n == 2:
        return 1
    else:
        print(f_n_minus_2)
        print(f_n_minus_1)
        for i in range(1, n - 1):
            f_n = f_n_minus_2 + f_n_minus_1
            f_n_minus_2 = f_n_minus_1
            f_n_minus_1 = f_n
            print(f_n)
        return f_n


fibonacci_loop(n)

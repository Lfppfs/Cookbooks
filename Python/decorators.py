# this is a simple example of how decorators work
# A decorator in Python is any callable Python object that is used to modify a function or a clas
# see https://www.python-course.eu/python3_decorators.php for a more thorough explanation
# take a look at what this part does:

def decorator_func1(func):
    print('executing func')
    return func()


def decorated_func1():
    print('this is the decorated function')


decorator_func1(decorated_func1)

# now take a look at this part. it does the same as above, but using a decorator:
# note that decorator_func1 returns func(), but decorator_func2 returns func


def decorator_func2(func):
    print('executing func')
    return func


@decorator_func2
def decorated_func2():
    print('this is the decorated function')


decorated_func2()

# below are some weird examples of decorators from the same page linked above

print("\n weird example 1 \n")


def f(x):
    def g(y):
        return y
    return g


nf1 = f(1)
nf2 = f(2)

print(nf1(3))
print(nf2(4))

print("\n weird example 2 \n")


def f(x):
    def g(y):
        return y + x
    return g


nf1 = f(1)
nf2 = f(2)

print(nf1(3))
print(nf2(4))

print("\n weird example 3 \n")


def our_decorator(func):
    def function_wrapper(x):
        print("Before calling " + func.__name__)
        res = func(x)
        print(res)
        print("After calling " + func.__name__)
    return function_wrapper


@our_decorator
def succ(n):
    return n + 1


succ(10)

print("\n weird example 4 \n")


def call_counter(func):
    def helper(x):
        helper.calls += 1
        return func(x)
    helper.calls = 0

    return helper


@call_counter
def succ(x):
    return x + 1


succ(1)
print(succ.calls)
succ(10)
print(succ.calls)
succ(4)
print(succ.calls)


for i in range(10):
    succ(i)

print(succ.calls)

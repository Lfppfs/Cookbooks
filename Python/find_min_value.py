# this was a test for an interview (do not upload to github)
# from codility

# Write a function:
#     def solution(A)
# that, given an array A of N integers, returns the smallest positive integer (greater than 0) that does not occur in A.
# For example, given A = [1, 3, 6, 4, 1, 2], the function should return 5.
# Given A = [1, 2, 3], the function should return 4.
# Given A = [−1, −3], the function should return 1.
# Write an efficient algorithm for the following assumptions:
#         N is an integer within the range [1..100,000];
#         each element of array A is an integer within the range [−1,000,000..1,000,000].


import numpy as np

# the solution below works for these arrays
vec = np.random.randint(10 ** 6, size=10 ** 5)
# vec = np.array([1, 3, 6, 4, 1, 2])
# vec = np.array([1, 2, 3])
# vec = np.array([-1, -3])
# vec = np.array([1, 5, 0, 2, -7])
# vec = np.array([-1, 5, 0, 2, -7])


def solution(vec):
    vec_copy = vec
    vec_copy.sort()
    vec_copy = vec_copy[vec_copy >= 0]
    if len(vec_copy) == 0:
        return 1
    else:
        for i in range(0, len(vec)):
            min_val1 = abs(np.min(vec_copy))
            print('min = ', min_val1, '\tnew_vec = ', vec_copy)
            vec_copy = vec_copy[vec_copy != np.min(vec_copy)]
            if np.isin(min_val1 + 1, vec, invert=True):
                return(min_val1 + 1)


print(solution(vec))


# # non-efficient solution
# vec = [1, 2, 3]
# vec_copy = vec

# def solution(vec):
#     if max(vec) < 0:
#         if 1 in vec:
#             for i in range(0, len(vec)):
#                 min_val1 = min(vec_copy)
#                 vec_copy.remove(min(vec_copy))
#                 print('min = ', min_val1, '\tnew_vec = ', vec_copy)
#                 if min_val1 + 1 not in vec:
#                     print('aqui 1')
#                     return(min_val1 + 1)
#         else:
#             return(1)
#     for i in range(0, len(vec)):
#         min_val1 = abs(min(vec_copy))
#         vec_copy.remove(min(vec_copy))
#         print('min = ', min_val1, '\tnew_vec = ', vec_copy)
#         if min_val1 + 1 not in vec:
#             print('aqui 2')
#             return(min_val1 + 1)


# print(solution(vec))

# this finds the minimum value in a list
# vec = [1, 3, 6, 4, 1, 2]
# vec = [201, 4, 200, 5, 1, 2, 3, 100, -100, 10, -101, 500]
# min_val = vec[0]
# for i in range(1, len(vec)):
#     if min_val >= vec[i]:
#         min_val = vec[i]

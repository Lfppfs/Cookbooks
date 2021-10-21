import pandas as pd
import numpy as np
import random

# df3 = pd.DataFrame({
#     'a': np.random.randint(5, 10),
#     'b': ['Q', 'W', 'E', 'R', 'T']
# }, index=['i1', 'i2', 'i3', 'i4', 'i5'])

# # loc is mostly(?) used with index labels
# print('df3.loc["i1"]=\n', df3.loc['i1'])
# print('df3.loc["i1", "b"]=\n', df3.loc['i1', 'b'])
# # loc is mostly(?) used with integer positions
# print('df3.iloc[3]=\n', df3.iloc[3])
# # an index on a Series or column on a DataFrame may be accessed directly as an attribute
# print('df3.b=\n', df3.b)

# df1 = pd.DataFrame({
#     'a': np.random.randint(0, 20, 12),
#     'b': np.random.randint(0, 20, 12)
# }, index=np.arange(12))
# print(df1)
# # print(df1.iloc[0])
# # print(df1.iloc[0].name)

# # if one needs to grab all values that come before the 1st number three in a or b:
# if any(df1['a'] < 3) or any(df1['b'] < 3):
#     condition = (df1['a'] < 3) | (df1['b'] < 3)
#     df2 = df1[0:df1[condition].iloc[0].name]
#     print('df2=\n', df2)

# print('\n\n\n\n')


df4 = pd.DataFrame({
    'a': np.array([0.00402, 0.2, 5.000e-02]),
    'b': np.array([0.00402, 0.2, 5.000e-02])
}, index=np.arange(3))
print(df4)
# print(df4['a'].array)
# print(np.around(df4, 3))

print('\n\n')

# df4 = np.around(df4, 0)
# print(df4)

# df4 = np.rint(df4)
# print(df4)

print(df4['a'].array.astype(int))

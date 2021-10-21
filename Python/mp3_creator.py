import os.path
from os import chdir, getcwd, listdir, mkdir, rename, fdopen
import re
import pandas as pd

chdir("/home/lfppfs/Desktop/test")

match = '.xlsx'

df1 = pd.read_excel(
    'tombar.xlsx', usecols='D,Q', names=['numbers', 'names'])

chdir("/home/lfppfs/Desktop/test/new")

for n in df1['names']:
    with open(''.join([str(n), '.mp3']), '+w') as f:
        f.write('')
    print(n)
    # if re.search('.mp3', item):
    # rename(item, ''.join(['FNJV_00', str(df1['numbers'][n]), '.mp3']))

# FNJV_0045434.mp3

import os
import re
os.chdir("/home/lfppfs/Desktop/PED/trabalhos/trabalhos_RAs")

for item in sorted(os.listdir()):
    print(''.join(re.findall("[0-9]", item)[0:6]))
    os.rename(item, ''.join(re.findall("[0-9]", item)[0:6]))

# print(''.join(re.findall("[0-9]", sorted(os.listdir())[0])[0:6]))
# for file in os.listdir():
#     print(re.search(file, 'a'))

# this code was taken from CoreySchafer: https://www.youtube.com/watch?v=_P7X8tMplsw&list=WL&index=1&t=1s
# downloading files tutorial: https://aviaryan.com/blog/gsoc/downloading-files-from-urls

import csv
# import requests
import zipfile
import os
from collections import defaultdict, Counter

os.chdir("/home/lfppfs/Desktop")

# r = requests.get(
#     'https://doc-0c-68-docs.googleusercontent.com', allow_redirects=True)
# print(r.headers.get('content-type'))

# open('file.zip', 'wb').write(r.content)

# unzipping to a new folder called 'stack_survey'
with zipfile.ZipFile('developer_survey_2020.zip', 'r') as my_zip:
    my_zip.extractall('stack_survey')

# using the DictReader method to create a dictionary from which keys
# are variable names (column header entries) and values are entries

with open('./stack_survey/survey_results_public.csv', 'r') as f:
    csv_reader = csv.DictReader(f)
    total = 0
    # for lines in csv_reader: # read only the first line
    #     print(lines)
    #     break

    # counter method counts variables, and it's going to be used below
    language_counter = Counter()

    # this block will read the column LanguageWorkedWith, split it
    # at semi-colons and then update the counter created above
    for line in csv_reader:
        languages = line['LanguageWorkedWith'].split(';')
        language_counter.update(languages)
        total += 1

    # language_counter contains the number of entries of each language in the csv file
    # print(language_counter)
    # printing 5 most common languages
    print(language_counter.most_common(5))

# calculating percentage of most common languages:
for language, value in language_counter.most_common(5):
    language_pct = round((value / total) * 100, 2)

    print(f'{language}: {language_pct}%')

# below the code does the same as above, but calculates percentage by developer type
with open('./stack_survey/survey_results_public.csv', 'r') as f:
    csv_reader = csv.DictReader(f)
    dev_type_info = {}

    for line in csv_reader:
        dev_types = line['DevType'].split(';')

        # creating a dict whose keys will be the entries from the DevType column
        # for dev_type in dev_types:
        # dev_type_info[dev_type] = {}

        # same as above, but here the setdefault method checks if the dictionary
        # already has the value from the iterator dev_type, and if it does, then it
        # just returns those values, and if it doesn't, it will create a new dict with
        # a counter initialized
        for dev_type in dev_types:
            dev_type_info.setdefault(dev_type, {
                'total': 0,
                'language_counter': Counter()
            })

            languages = line['LanguageWorkedWith'].split(';')
            dev_type_info[dev_type]['language_counter'].update(languages)
            dev_type_info[dev_type]['total'] += 1

for dev_type, info in dev_type_info.items():
    print(dev_type)
    # print(info)  # info is a dict containing the total number of answers and the Counter object with each language and their
    # respective number of users

    # iterate through the info dict
    for language, value in info['language_counter'].most_common(5):
        language_pct = (value / info['total']) * 100
        language_pct = round(language_pct, 2)

        print(f'\t{language}: {language_pct}%')

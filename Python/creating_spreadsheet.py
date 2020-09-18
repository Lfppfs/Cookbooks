# I created this script when I had to search a folder for wav files and
# create an excel spreadsheet with their names

import os.path
from os import chdir, listdir
import re
import pandas as pd

chdir('/home/user/folder_to_store_spreadsheet')

match = '.wav'

file_dict = {
    'files':
    sorted([item for item in
            listdir(
                os.path.join(
                    '/home/user/target_folder/'
                )
            ) if re.search(match, item)])
}

file_df = pd.DataFrame(file_dict)

file_df.to_excel(f'{match[1:]}_files.xlsx')

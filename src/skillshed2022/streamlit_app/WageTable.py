import numpy as np
import pandas as pd
from os import getcwd, listdir
from OccupationsOfInterest import occ_list

# Read the OH_OEWS_21.csv
data_path = getcwd() + "/data/raw/OH_OEWS_21.csv"

df = pd.read_csv(data_path)

# Filter with the following columns
cols = ['SOC_CODE', 'TITLE', 'A_MEDIAN']

sub_df = df[cols]

# Retrieve OCC List
occ_df = occ_list.copy()

occ_df.columns

# Keep SubFrame of just SOC_Code and GROW
sub_occ_df = occ_df[['SOC_Code', 'Grow']]
sub_occ_df.columns = [col.upper() for col in sub_occ_df.columns.tolist()]

sub_occ_df.head()
sub_df.shape

# Join with the wages dataframe
oews_wage = sub_df.merge(sub_occ_df, on=['SOC_CODE']).sort_values('TITLE')

# Check dtypes of dataframe
oews_wage.info()

# Cast type of A_MEDIAN as int32 in numpy
oews_wage['A_MEDIAN'] = oews_wage['A_MEDIAN'].astype(np.int32)

# Get the Wage Column by Dividing MEDIAN by 1000
oews_wage['WAGE'] = oews_wage['A_MEDIAN'] / 1000

# Drop the A_MEDIAN column
oews_wage.drop('A_MEDIAN', axis=1, inplace=True)

# Reset the index and drop extra index column
oews_wage = oews_wage.reset_index().drop('index', axis=1)

# Rearranging the index to start from 1
oews_wage.index = range(1, oews_wage.shape[0]+1)

# View table
print(oews_wage)

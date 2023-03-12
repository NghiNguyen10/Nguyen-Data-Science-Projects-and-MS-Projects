import pandas as pd
from os import getcwd, listdir
from warnings import filterwarnings
from CombiningFourDataFiles import skillshed

filterwarnings('ignore')

# Create Copy of Result DF and call it df
df = skillshed.copy()

# Create the Grow List
grow_list = pd.DataFrame({'SOC_Code': list(set(
    ['25-2011.00', '29-2052.00', '31-1131.00', '31-2021.00', '31-9091.00', '33-9032.00']))})

# Create the Decline List
decline_list = pd.DataFrame({'SOC_Code': list(set(['23-2093.00', '27-1026.00', '43-3011.00', '43-3031.00', '43-3051.00', '43-3061.00',
                            '43-4071.00', '43-4151.00', '43-4161.00', '43-5032.00', '43-6011.00', '43-6014.00', '43-9021.00', '43-9061.00']))})

# Create the OCC List

## Group the SOC Codes in both lists together
occ_list = pd.concat([decline_list, grow_list]
                     ).reset_index().drop('index', axis=1)

## Set the Grow column to Yes
occ_list['Grow'] = 'Y'

records_to_replace = occ_list[occ_list['SOC_Code'].isin(
    decline_list['SOC_Code'].tolist())].index

# Replacing values based on index: Use .loc
## First argument is the index values, second is the column name
## Right side of = will be the new value
## https://stackoverflow.com/questions/37725195/pandas-replace-values-based-on-index
occ_list.loc[records_to_replace, 'Grow'] = 'N'

# Filter the original dataframe based on SOC Codes in the occ_list
# occ_list = df[df['SOC_Code'].isin(occ_list['SOC_Code'].tolist())].reset_index().drop('index', axis=1)
occ_list = occ_list.merge(df, on='SOC_Code', how='inner')

# occ_list.to_csv(f"{data_path}/OCC_List.csv", index=False)

print(occ_list.head())
print(occ_list.shape)
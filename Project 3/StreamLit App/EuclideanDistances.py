import pandas as pd
from os import getcwd, listdir
from scipy.spatial.distance import euclidean
from OccupationsOfInterest import occ_list

reordered_columns = ['SOC_Code'] + occ_list.columns.tolist()[2:] + ['Grow']

occ_list = occ_list[reordered_columns]

grow_titles = occ_list[occ_list['Grow'] == 'Y']['Title']

decline_titles = occ_list[occ_list['Grow'] == 'N']['Title']


def make_dict(titles, df):
    # Get Specific Columns from the DataFrame
    cols = df.columns.tolist()
    sub_df = df[cols[2:-1]]
    # sub_df = sub_df.drop('_NAME_', axis=1)

    # Titles is a pandas Series
    row_ind = titles.index.values
    title_values = titles.values

    return {title: sub_df.iloc[i].values for i, title in zip(*[row_ind, title_values])}


grow_dict = make_dict(grow_titles, occ_list)
decline_dict = make_dict(decline_titles, occ_list)

# Euclidean Distance

# Keep track of each growing job as a key in the dictionary below
distance_dict = {}

for g_key in grow_dict.keys():
    # Retrieve numpy array for growing job
    u = grow_dict[g_key]
    # Store calculated distances in this list
    distances = []
    for d_key in decline_dict.keys():
        # Retrieve numpy array for declining job
        v = decline_dict[d_key]
        # Calculate the Euclidean Distance
        distance = euclidean(u, v)
        # Add the distance to the distances list
        distances.append(distance)
    distance_dict[g_key] = distances

final_result = pd.DataFrame(distance_dict).T

final_result.columns = list(decline_dict.keys())

# Sort the Indexes and the Columns

## Sort Columns
new_cols = sorted(final_result.columns.tolist())
final_result = final_result[new_cols]

## Sort the Indexes
new_inds = sorted(final_result.index.tolist())
final_result = final_result.loc[new_inds]

# Get the Title Column
final_result.reset_index(inplace=True)
final_result.columns = ['Title'] + final_result.columns.tolist()[1:]

# # Save Final DataFrame
# final_result.to_csv(f"{data_path}/Final_Result.csv")

print(final_result)
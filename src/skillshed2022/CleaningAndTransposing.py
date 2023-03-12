import pandas as pd
from os import getcwd, listdir, chdir
from os.path import splitext

data_path = getcwd() +  "/data/raw"

list_of_files = [file for file in listdir(data_path) if 'Onet' in file]

list_of_files

# Read All the Files as CSVs into a Dictionary
data_dict = {splitext(key)[0].split("_")[1]: pd.read_csv(f"{data_path}/{key}") for key in list_of_files}

# Select DataFrames for Transposing
transpose_dict = {k:v for k,v in data_dict.items() if k in list(data_dict.keys())[1:]}

transpose_dict.keys() 
transpose_dict['WorkContext'].columns # Testing


# Creating a Function to apply Filter to All the Files
def clean_filter(df, scale_name_category):

    df = df[df['Scale_Name'] == scale_name_category]

    filtered_cols = ['SOC_Code', 'Title', 'Element_ID', 'Element_Name', 'Scale_Name', 'Data_Value']

    important_df = df[filtered_cols]

    return important_df


## Transpose from Pandas Transform

# Helper Function
def transform(sub_df):
    # Create a selection to perform a transpose
    transpose_test = sub_df[['Element_Name', 'Data_Value']].T
    transpose_test.columns = transpose_test.iloc[0]
    second_frame = transpose_test[1:].reset_index().drop('index', axis=1)

    # First Frame (Info that stays the same)
    code_title_frame = sub_df[['SOC_Code', 'Title']].iloc[0:1]
    first_frame = code_title_frame.reset_index().drop('index', axis=1)

    return pd.concat([first_frame, second_frame], axis=1)

## Wrap as function
def transpose_func(df, n):
    # Getting Number of Partitions
    partition_count = int(df.shape[0] / n)

    # Empty List to store partitions
    temp_df_partitions = []

    # Going through each partition
    for i in range(partition_count):
        # Getting a specific partition
        temp_df = df.iloc[i*n:(i+1)*n]
        # Applying transform to partition
        temp_df = transform(temp_df)
        # Adding transformed partition into partition list
        temp_df_partitions.append(temp_df)

    # Consolidating all partitions into single DataFrame
    final_df = pd.concat(temp_df_partitions)

    return final_df

# Output to CSV
output_path = getcwd() + "/data/sas_to_pandas/transformed"

# Applying Cleaning to Knowledge Wide
knowledge_2 = clean_filter(transpose_dict['Knowledge'], 'Importance')

knowledge_wide = transpose_func(knowledge_2, 33)

# knowledge_wide.to_csv(f"{output_path}/KNOWLEDGE_WIDE.csv", index=False)

# Applying Cleaning to Work Activities
work_activity_2 = clean_filter(transpose_dict['WorkActivities'], 'Importance')
work_activity_wide = transpose_func(work_activity_2, 41)
# work_activity_wide.to_csv(f"{output_path}/WORK_ACTIVITY_WIDE.csv", index=False)

# Applying Cleaning to Work Context
work_context_2 = clean_filter(transpose_dict['WorkContext'], 'Context')
work_context_wide = transpose_func(work_context_2, 57)
# work_context_wide.to_csv(f"{output_path}/WORK_CONTEXT_WIDE.csv", index=False)

# Cleaning Job Zone
cols_to_keep = data_dict['JobZones'].columns.tolist()[:3]
job_zones_2 = data_dict['JobZones'][cols_to_keep]
# job_zones_2.to_csv(f"{output_path}/Job_Zones_2.csv", index=False)

knowledge_wide.head()

work_activity_wide.head()

work_context_wide.head()

job_zones_2.head()
import pandas as pd
from os import getcwd, listdir, chdir
from warnings import filterwarnings

filterwarnings('ignore')

#import pandas as pd
#from os import getcwd, listdir
from CleaningAndTransposing import knowledge_wide, work_activity_wide, work_context_wide, job_zones_2

# Joins
frame_order = [knowledge_wide, work_activity_wide, work_context_wide, job_zones_2]

## Merge Function
def merge_frames(frames: list, cols_to_join=['SOC_Code']):
    # Join the DataFrames
    result = frames[0]
    for i in range(1, len(frames)):
        result = result.merge(frames[i], on=['SOC_Code'], how='inner')

    return result


# Duplicate Filter Function
def find_duplicate_cols(df):
    # Find Duplicate Columns
    duplicate_cols = []

    for col in df.columns.tolist():
        if '_x' in col:
            duplicate_cols.append(col)
        elif '__x' in col:
            duplicate_cols.append(col)
        elif '_y' in col:
            duplicate_cols.append(col)
        elif '__y' in col:
            duplicate_cols.append(col)
        else:
            continue
    return duplicate_cols

# Keep the Title column
def create_col(df, col: str):

    # Find all columns that contain your input col string
    cols = [elem for elem in df.columns.tolist() if col in elem]

    # Secondary DataFrame
    secondary_df = df[cols]

    # Rename Columns
    secondary_df.columns = [f"col_{i+1}" for i in range(secondary_df.shape[1])]

    # Generate a Series of Cardinality Values for the Above Columns
    cardinality_series = secondary_df.nunique()

    # Choose the record that has the maximum value for cardinality
    cardinality_record = cardinality_series[cardinality_series == max(cardinality_series.values)]

    # Select the col corresponding to the above record
    selected_col = cardinality_record.index[0]

    # Save the Series from the above col
    saved_series = secondary_df[selected_col]

    # Remove the cols
    df.drop(cols, axis=1, inplace=True)

    # Create the new column
    df[col] = saved_series.tolist()

    return df

# Applying the Functions
skillshed = create_col(merge_frames(frame_order), 'Title')

## Reorder the Columns
result_cols = ['SOC_Code', 'Title'] + sorted(skillshed.columns.tolist()[1:-1])
skillshed = skillshed[result_cols]


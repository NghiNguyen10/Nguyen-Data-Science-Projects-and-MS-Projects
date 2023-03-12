import pandas as pd
from db_config import parse_credentials, create_connection
from os import getcwd, listdir
from os.path import splitext

# Credentials Path
cred_path = getcwd() + "/src/sql_training/etl/credentials.txt"

# Create the credentials list
cred_list = parse_credentials(cred_path)

print(cred_list)

# Create PostgreSQL connection
con = create_connection(cred_list)

# Data Path
data_path = getcwd() + "/data/sql_data/airlines"

# All the File Names
data_files = [file for file in listdir(
    data_path) if splitext(file)[1] == '.csv']

# Dictionary of DataFrames
df_dict = {splitext(name)[0]: pd.read_csv(
    f"{data_path}/{name}") for name in data_files}

# Iterate through dataframes and load onto the SQL database
for key in df_dict:
    # Get each dataframe
    df = df_dict[key]

    # Load each DataFrame as a Postgres DB table
    df.to_sql(key, con=con, index=False)

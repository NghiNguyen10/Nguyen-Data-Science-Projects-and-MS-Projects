import pandas as pd
from FCM_MD import FCM_MD
from os import getcwd

# Path to Data
data_path = getcwd() + "/data/raw"

# Read the DataFrame
df = pd.read_csv(f"{data_path}/OCC_testrun.csv")

# Instnatiate the FCM_MD Class
fcm_md = FCM_MD(df)

# Create the FCM Results with 3 clusters
results = fcm_md.fcm(num_clusters=4)

# View Results DataFrame
print(results.head())

# Viewing the centers
print(fcm_md.centers.shape)

cen_x = [i[0] for i in fcm_md.centers]
cen_y = [i[1] for i in fcm_md.centers]

print(cen_x)
# print(cen_y)
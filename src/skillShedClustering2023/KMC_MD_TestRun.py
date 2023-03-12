import pandas as pd
from KMC_MD import KMC_MD
from os import getcwd

# Path to Data
data_path = getcwd() + "/data/raw"

# Read the DataFrame
df = pd.read_csv(f"{data_path}/OCC_testrun.csv")

# Instnatiate the kmc_md Class
kmc_md = KMC_MD(df)

# Create the K Means Results with 3 clusters
results = kmc_md.kmeans(num_clusters=3)

# View Results DataFrame
print(results.head())

# Viewing the centers
print(kmc_md.centers.shape)

cen_x = [i[0] for i in kmc_md.centers]
cen_y = [i[1] for i in kmc_md.centers]

print(cen_x)
print(cen_y)
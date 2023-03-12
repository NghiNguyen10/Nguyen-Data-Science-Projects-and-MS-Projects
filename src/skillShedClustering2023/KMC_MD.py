"""
K Means Clustering on Multi-dimensional Features

Algorithm:

Before using KMC algorithm, we transform the feature space into a 2-dimensional space by utilizing the t stochastic neighbor embedding (t-SNE) algorithm.

"""
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.manifold import TSNE

class KMC_MD:
    def __init__(self, df):
        self.df = df
    
    def retrieve_components(self):
        # Retrieve numeric features
        self.df = self.df.select_dtypes('number')

        # Retrieve features
        features = self.df.values

        # Create tSNE Components
        tsne = TSNE(n_components=2, verbose=1, random_state=123)

        return tsne.fit_transform(features)
    
    def kmeans(self, num_clusters: int):
        # Instantiate FCM Algorithm
        self.model = KMeans(n_clusters=num_clusters)

        # Instantiate Lower Dimensional DataFrame
        result_df = pd.DataFrame()

        z = self.retrieve_components()

        result_df['comp-1'] = z[:,0]
        result_df['comp-2']= z[:,1]

        # Use Features from t-SNE Components
        features = result_df.values

        # Fit FCM Model
        self.model.fit(features)

        # Centers, Labels
        self.centers = self.model.cluster_centers_
        self.labels = self.model.predict(features)

        # Look at the the two artifacts as a DataFrame
        result_df['cluster_labels'] = self.labels

        return result_df



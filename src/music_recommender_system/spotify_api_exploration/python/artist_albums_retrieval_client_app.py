import pandas as pd
import streamlit as st
from artist_albums_oop import ArtistAlbums

# Title for the application
st.title("Artist Albums Retrieval Application")

# Supplying Artist Link
artist_link = st.text_input("Type in your Spotify Artist Link: ")

# Instantiate the class
aa = ArtistAlbums(artist_link)

# Get the Transformed Results
results = aa.retrieve_transformed_results('single')

# View Results as a DataFrame
st.dataframe(pd.DataFrame(results))
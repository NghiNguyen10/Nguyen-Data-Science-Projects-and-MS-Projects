import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
from getpass import getpass

# Create the Values for Client ID and Client Secret
client_id = input("Type in your Client ID: ")
client_secret = getpass("Type in your Client Secret: ")

# Set Up Credentials and Instantiate Client
auth_credential_manager = SpotifyClientCredentials(
    client_id=client_id, client_secret=client_secret)

client = spotipy.Spotify(client_credentials_manager=auth_credential_manager)

# URI for Maasho
maasho_uri = "spotify:artist:1JREmglx633MGQB73njWtE"

# Retrieve Albums of Maasho
results = client.artist_albums(maasho_uri, album_type='album')

# Print the Type of Results
print(type(results))



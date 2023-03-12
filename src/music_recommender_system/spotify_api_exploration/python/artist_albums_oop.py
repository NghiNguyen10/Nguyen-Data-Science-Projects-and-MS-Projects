import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
from functools import reduce

def value_transform(dct: dict, str_keys: list):
    # Dictionary Containing only the string keys
    sub_dct = {k:[v] for k,v in dct.items() if k in str_keys}
    return sub_dct

def items_transform(artist_items_list: list, str_keys: list):
    # Map Each Internal Dictionary into the Value Transform
    transformed_items_list = list(map(lambda d: value_transform(d, str_keys), artist_items_list))

    # Instantiate a New Dictionary
    result_dict = {k: [] for k in str_keys}

    # Iterate through each str_key and each item
    for item in transformed_items_list:
        for k, v in item.items():
            result_dict[k].append(v)
    
    return {k: reduce(lambda a,b : a+b, v) for k, v in result_dict.items()}



class ArtistAlbums:
    def __init__(self, spotify_artist_link: str):
        self.client_id = '4ebf1d0af4bd48f4b9c99841121ee303'
        self.client_secret = 'e6ef97b039494af3997750d0afb876bd'
        self.auth_manager = SpotifyClientCredentials(
    client_id=self.client_id, client_secret=self.client_secret)
        self.client = spotipy.Spotify(client_credentials_manager=self.auth_manager)
        self.artist_link = spotify_artist_link
    
    def generate_spotify_uri(self):
        # Separate the original string by the ? in the URL
        q_separate = self.artist_link.split("?")[0]

        # Split the q_separate by /
        q_part_2 = q_separate.split("/")[-1]

        self.spotify_uri = f"spotify:artist:{q_part_2}"

        return self.spotify_uri
    
    def retrieve_album_results(self, album_type):
        # Get Valid Spotify Artist URI
        artist_uri = self.generate_spotify_uri()

        # Assign results to artist_albums() method
        self.results = self.client.artist_albums(artist_uri, album_type=album_type)

        return self.results
    
    def retrieve_transformed_results(self, album_type):

        self.retrieve_album_results(album_type)

        sample_result = self.results['items'][0]

        # See Types of Values for all Keys in the Dictionary
        bool_dct_key_types = list(map(lambda k: type(sample_result[k]) == type(''), sample_result.keys()))

        keys = list(sample_result.keys())

        str_dct_key_types = [keys[i] for i, val in enumerate(bool_dct_key_types) if val == True]

        self.results = items_transform(self.results['items'], str_dct_key_types)

        return self.results
    
   



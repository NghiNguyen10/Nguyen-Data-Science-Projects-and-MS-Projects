from sqlalchemy import create_engine

# Get the connection information


def parse_credentials(path: str):
    cred_info = []

    # Read the .txt file
    with open(path, "r") as my_file:
        # Read all the lines and add into a list
        for line in my_file.readlines():
            # Replace the \n markers
            line = line.replace("\n", "")
            # Append to the cred_info list
            cred_info.append(line)
        my_file.close()

    # Return the populated list
    return cred_info

# Create Connection Function


def create_connection(information):
    # Get entities of the Postgres connection from the list
    server, port, database, user, password = information

    # Create a Postgres dialect for sqlalchemy's create_engine
    dialect = f"postgresql://{user}:{password}@{server}:{port}/{database}"

    # Create the connection object
    con = create_engine(dialect).connect()

    return con

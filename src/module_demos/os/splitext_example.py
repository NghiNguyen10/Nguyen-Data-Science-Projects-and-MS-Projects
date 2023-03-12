from os.path import splitext

# Have a sample .txt file
example_file = 'random_file_name.txt'

def file_ext_split(name):
    return name.split(".")

print(file_ext_split(example_file))

example_file_2 = 'random.file.name.txt'

print(file_ext_split(example_file_2))

print(splitext(example_file_2))
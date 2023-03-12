# Reduce
from functools import reduce

## Use Case 1: Recreating the sum() function

sum_one = reduce(lambda a,b: a+b, range(1, 11))

## Use Case 2: List Flattening

# [[1], [2], [3], [4], [5]] -> [1,2,3,4,5]
l_input = [[1], [2], [3], [4], [5]]

flattened_list = reduce(lambda a,b: a+b, l_input)

flattened_list

# Recreate the join method in strings
str_input = "Yo yo yo, Pathrise is awesome!".split(" ")
str_input

sentence = reduce(lambda a,b: a+" "+b, str_input)

sentence

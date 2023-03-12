# Map

## Use Case 1: Squaring Numbers 1 through 1000

result = map(lambda x: x**2, range(1, 1001))
result = list(result)

## Use Case 2: Add "Hi" to each string
string_output = "Yo yo yo, Pathrise is really cool!".split(" ")

result_2 = map(lambda x: 'Hi ' + x, string_output)
result_2 = list(result_2)

result_2

def add_hi(x):
    return "Hi " + x

result_3 = map(add_hi, string_output)
result_3 = list(result_3)

result_3

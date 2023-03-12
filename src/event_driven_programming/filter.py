# Filter

## Use Case 1: Retrieve Numbers Greater than 1000

result = filter(lambda x: x > 1000, range(1, 1501))
result = list(result)

## Use Case 2: Get the even squared numbers

result_2 = filter(lambda y: y % 2 == 0, map(lambda x: x**2, range(1, 1001)))
result_2 = list(result_2)

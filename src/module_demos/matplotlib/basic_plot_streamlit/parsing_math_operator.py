# Parsing a STring to ACtually Compute a Math Operation
import numpy as np

x = np.arange(-1000, 1001)

input_buffer = input("Type in a mathematical expression that utilizes x: ")

y = eval(input_buffer)

print(y)

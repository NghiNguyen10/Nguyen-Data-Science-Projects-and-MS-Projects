import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Create two variables: X and Y
X = np.arange(-10000, 10000)

print(X.shape)

print(type(X))

# Quadratic Function: X^2
Y = X**2

# Cubic Function: X^3
Y2 = X**3

Y3 = Y2 + 2*X**2 + 4*X + 16

# # Line Plot
fig = plt.figure(figsize=(10, 10))
plt.title(r"$Y=X^2$ vs $Y=X^3$", size=16)
plt.plot(X, Y)
plt.plot(X, Y2)
plt.xlabel("X", size=12)
plt.ylabel("Y", size=12)
plt.text(0.0, 0.5, r"i = 0", size=14)
plt.legend()
plt.show()


# Pandas Version
df = pd.DataFrame({'X^2': Y, 'X^3': Y2, 'X^3 + 2X^2 + 4X + 16': Y3})

plt.figure(figsize=(10, 10))
df.plot(kind='line')
plt.show()

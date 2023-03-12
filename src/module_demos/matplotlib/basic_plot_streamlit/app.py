import numpy as np
import matplotlib.pyplot as plt
import streamlit as st

# Title for the Application
st.title("Curve Graphing")

# Options
options = ['Quadratic', 'Cubic', 'Square Root']

# Specified Range for X
x = np.arange(-1000, 1001)

# Drop Down Menu
option = st.selectbox(
    "Choose a function to graph on a Cartesian plane: ", options=options)

# Functions for Each Type of Graph


def graph(x, y):
    fig = plt.figure(figsize=(10, 10))
    plt.plot(x, y)
    st.pyplot(fig)

# Function to Generate Specific Plot


def select_graph(x, option_key):
    results = [x**2, x**3, np.sqrt(x)]

    option_dict = {elem: results[i] for i, elem in enumerate(options)}

    graph(x, option_dict[option_key])


if st.button("Graph", key='button_1'):
    select_graph(x, option)

# Create a Custom Function Grapher
user_result = st.text_area(
    "Type in a mathematical function that utilizes x: ", placeholder="x**2 + 4*x + 4")

if st.button("Graph", key='button_2'):
    graph(x, eval(user_result))

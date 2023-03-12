## Introduction to Streamlit

### Agenda

1. Creating a Web Server for the Streamlit App
   <br />
2. Creating a Simple Input / Output App
   <br />
3. DataFrame App

### Fundamental Knowledge

- Streamlit is a web application framework for Python. Behind the scenes, it leverages another popular web framework known as `Flask`.

It uses Flask to create a web server and then Streamlit uses object-oriented programming to generate different assets which then get converted into front-end web HTML components.

#### Example: Creating a Button

- HTML and JavaScript

```html
<button id='myButton1'>My Button</button>

<!-- The logic for the button is usually done in JavaScript !-->
<script src="javascript">

document.findElementById('myButton1').onClick(// Some Logic)

<script/>
```

$$ \downarrow $$

- Streamlit

```python
if st.button("My Button"):
    # Some Logic
```

### Creating a Web Server Using Streamlit

Since Streamlit utilizes Flask behind the scenes, you have to leverage a command interface that will allow you to run the Streamlit web server.

The CLI command for Streamlit is just `streamlit`.

To run a web server, you use the `streamlit run` command. The name of the Python file that saves the logic of the app must come after this command.

- Example: `main.py`

```bash
streamlit run main.py
```

- This command above will generate a Streamlit server that runs on a default port on your browser's localhost to view the application.

- If you want to change properties of the final serving, you can add additional arguments using `--` .

  - Example: Changing the Port Number

  ```bash
  streamlit run main.py --server.port 1820
  ```

  - This command above will change the port number to 1820.
  - App will run on `localhost:1820`

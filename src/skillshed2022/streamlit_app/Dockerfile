FROM python:3.10

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 8201

CMD streamlit run app.py --server.port 8201 --server.enableCORS true


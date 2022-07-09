FROM python:3.11.0a5-alpine3.15

WORKDIR /rp

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

ENV FLASK_APP=app.py
# ENV FLASK_DEBUG=1
# ENTRYPOINT  ["flask", "run", "--host", "0.0.0.0", "--port", "5000"]
ENTRYPOINT  ["python3", "server.py"]
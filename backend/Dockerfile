FROM python:3.11.0b4-bullseye

WORKDIR /rp

COPY requirements.txt requirements.txt
RUN python3 -m pip install -r requirements.txt

COPY . .

ENV FLASK_APP=app.py
# ENV FLASK_DEBUG=1
# ENTRYPOINT  ["flask", "run", "--host", "0.0.0.0", "--port", "5000"]
ENTRYPOINT  ["python3", "server.py"]
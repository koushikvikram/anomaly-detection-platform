FROM python:3.7-slim

RUN mkdir prediction-api

WORKDIR /prediction-api

COPY ./service/requirements.txt /prediction-api/
RUN pip install -r requirements.txt

COPY ../jupyter/anomaly-model.joblib /prediction-api/
COPY ./service/main.py /prediction-api/

CMD python /prediction-api/main.py
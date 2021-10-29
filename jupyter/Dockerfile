FROM python:3.7-slim
RUN mkdir src
WORKDIR /src
COPY requirements.txt /src/
RUN pip install -r requirements.txt
CMD jupyter lab --port=8888 --no-browser --ip=0.0.0.0 --allow-root
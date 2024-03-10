FROM python:3.12.2-slim-bullseye
RUN python -m pip install poetry==1.8.0

WORKDIR /app

COPY . . 

RUN poetry build

EXPOSE 8000
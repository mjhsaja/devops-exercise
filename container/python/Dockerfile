# Use an official Python runtime as a parent image
FROM python:3.10-slim-bullseye

# Set environment varibles
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies
RUN apt-get update && apt-get install -y netcat

# Install poetry
RUN pip install "poetry==1.1.8"

# Set work directory
WORKDIR /app

# Copy only requirements to cache them in docker layer
COPY pyproject.toml poetry.lock /app/

# Project initialization:
RUN poetry config virtualenvs.create false \
  && poetry install --no-interaction --no-ansi

# Copy project
COPY . /app/

# Expose port
EXPOSE 8000

# Set the entrypoint
ENTRYPOINT ["poetry", "run"]

# Set the default command to start the app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
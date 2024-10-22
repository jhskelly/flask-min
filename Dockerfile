# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Copy the pyproject.toml and poetry.lock files to the container
COPY pyproject.toml poetry.lock /app/

# Install Poetry
RUN pip install --no-cache-dir poetry

# Install dependencies locally to /app/.venv (instead of globally)
RUN poetry config virtualenvs.in-project true \
    && poetry install --no-dev --no-interaction --no-ansi

# Copy the rest of the application code to the container
COPY . /app/

# Install zip utility
RUN apt-get update && apt-get install -y zip

# Create a zip file with the app code and dependencies
RUN zip -r /app.zip /app

# Command to output the zipped app for deployment
CMD ["cp", "/app.zip", "/mnt/app.zip"]

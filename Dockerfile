#use an official python runtime
FROM python:3.12-slim-buster

#Set env variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

#Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

#Install python dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

#Copy the current directory contents into the container at /app
COPY . /app

#Collect static files
RUN python manage.py collectstatic --noinput

#Expose the port that the Django app runs on
EXPOSE 8000

#Run the django development server 
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
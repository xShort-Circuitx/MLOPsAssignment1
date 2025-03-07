# Base image
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .


RUN pip install --no-cache-dir -r requirements.txt

COPY ./project /app/project


EXPOSE 5000

CMD ["python", "/app/project/app.py"]
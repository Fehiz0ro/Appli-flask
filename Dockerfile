FROM python:3.11-slim

WORKDIR /home/app

COPY requirements.txt /home/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /home/app/

EXPOSE 5000

CMD ["python", "app.py"]

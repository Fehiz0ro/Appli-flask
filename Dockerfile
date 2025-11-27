# Étape 1 : image de base Python
FROM python:3.10-slim

# Étape 2 : définir le dossier de travail dans le container
WORKDIR /app

# Étape 3 : copier et installer les dépendances
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Étape 4 : copier tout le reste du projet
COPY . .

# Étape 5 : exposer le port
EXPOSE 5000

# Étape 6 : lancer l'application
CMD ["python", "app.py"]

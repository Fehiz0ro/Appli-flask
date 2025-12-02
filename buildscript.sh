#!/bin/bash

set -e  # Arrête le script en cas d’erreur

echo "=============================="
echo " 🚀 BUILD ET DEPLOY DOCKER"
echo "=============================="

# Nom de l'image et du conteneur
IMAGE_NAME="mon_app_flask"
CONTAINER_NAME="mon_app_flask_container"
PORT=5000         # port interne Flask
LOCAL_PORT=5000   # port exposé en local

echo ""
echo "📄 Création du Dockerfile..."
cat <<EOF > Dockerfile
FROM python:3.11-slim

WORKDIR /home/app

COPY requirements.txt /home/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /home/app/

EXPOSE $PORT

CMD ["python", "app.py"]
EOF

echo "✔ Dockerfile créé."

echo ""
echo "🐳 Construction de l'image Docker..."
docker build -t $IMAGE_NAME .
echo "✔ Image construite : $IMAGE_NAME"

echo ""
echo "🚮 Suppression d’un éventuel ancien conteneur..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo ""
echo "🚀 Lancement du conteneur..."
docker run -d --name $CONTAINER_NAME -p $LOCAL_PORT:$PORT $IMAGE_NAME

CONTAINER_ID=$(docker ps -qf "name=$CONTAINER_NAME")

echo ""
echo "=============================="
echo " 🎉 DEPLOY TERMINÉ"
echo "=============================="
echo "🆔 ID du conteneur : $CONTAINER_ID"
echo "🌍 Accès à l'application : http://localhost:$LOCAL_PORT"
echo "=============================="

# 1. Image officielle Python légère
FROM python:3.12-slim

# 2. Répertoire de travail
WORKDIR /app

# 3. Configuration Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 4. Utilisateur root temporaire
USER root

# 5. Mise à jour des paquets Debian
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 6. Copier les dépendances
COPY requirements.txt .

# 7. Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir --upgrade "setuptools>=78.1.1"

# 8. Copier le code source
COPY app.py .

# 9. Utilisateur non privilégié
USER 10001:10001

# 10. Port de l'application
EXPOSE 5000

# 11. Démarrage
CMD ["python", "app.py"]

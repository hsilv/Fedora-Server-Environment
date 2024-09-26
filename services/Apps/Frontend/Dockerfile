FROM node:22-alpine

# Establecer el directorio de trabajo
WORKDIR /app

# Instalar git y openssh
RUN apk add --no-cache git openssh

# Copiar el archivo de variables de entorno
COPY .env .env

# Copiar la clave SSH para clonar el repositorio privado
COPY ssh.key /root/.ssh/id_rsa

# Asegurarse de que la clave SSH tenga los permisos correctos
RUN chmod 600 /root/.ssh/id_rsa

# Script para leer el archivo .env y clonar el repositorio
RUN set -a \
    && . .env \
    && ssh-keyscan github.com >> /root/.ssh/known_hosts \
    && git clone $REPO_URL /tmp/repo \
    && cp -r /tmp/repo/* /app/ \
    && rm -rf /tmp/repo \
    && rm /root/.ssh/id_rsa

# Instalar las dependencias
RUN npm install

# Exponer el puerto en el que la aplicación se ejecutará
EXPOSE 3000

# Comando para iniciar la aplicación
CMD ["npm", "run", "dev"]
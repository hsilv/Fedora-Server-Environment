# Usar la imagen base de Fedora
FROM fedora:latest

# Install Basics
RUN dnf -y update && \
    dnf -y install git  && \
    dnf -y install wget  && \
    dnf -y install systemd  &&\
    dnf -y install unzip 

# Crear el directorio de scripts
RUN mkdir -p /scripts

# Copiar todos los servicios
COPY services/ /services/

# Copiar todos los scripts al directorio de scripts
COPY install-scripts/ /install-scripts/
COPY init-scripts/ /init-scripts/

# Dar permisos de ejecución a todos los scripts
RUN chmod +x /install-scripts/*.sh
RUN chmod +x /init-scripts/*.sh

# Ejecutar todos los scripts y manejar errores
RUN for script in /install-scripts/*.sh; do \
    echo "Ejecutando $script"; \
    /bin/bash $script || { echo "Error ejecutando $script"; exit 1; }; \
    done

# Exponer el puerto de Jenkins
EXPOSE 8080

CMD ["bash"]
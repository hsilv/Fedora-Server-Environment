# Usar la imagen base de Fedora
FROM fedora:latest

# Crear el directorio de scripts
RUN mkdir -p /scripts

# Copiar todos los scripts al directorio de scripts
COPY install-scripts/ /install-scripts/

# Dar permisos de ejecución a todos los scripts
RUN chmod +x /install-scripts/*.sh

# Ejecutar todos los scripts
RUN for script in /install-scripts/*.sh; do $script; done

# Comando por defecto
CMD ["bash"]
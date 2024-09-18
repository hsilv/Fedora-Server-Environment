# Usar la imagen base de Fedora
FROM fedora:latest

# Instalar Docker dentro de la imagen
RUN dnf -y update && \
    dnf -y install dnf-plugins-core && \
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo && \
    dnf -y install docker-ce docker-ce-cli containerd.io && \
    dnf clean all

# Iniciar el servicio de Docker
RUN systemctl enable docker

# Comando por defecto
CMD ["bash"]
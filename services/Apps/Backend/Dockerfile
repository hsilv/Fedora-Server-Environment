FROM php:8.2-cli

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    libaio1 \
    unzip \
    git \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mbstring zip

# Copiar el archivo ZIP al contenedor
COPY instantclient-basic-linux.x64-19.24.0.0.0dbru.zip /opt/oracle/

# Instalar Instant Client de Oracle 19
RUN mkdir -p /opt/oracle \
    && cd /opt/oracle \
    && unzip instantclient-basic-linux.x64-19.24.0.0.0dbru.zip \
    && rm instantclient-basic-linux.x64-19.24.0.0.0dbru.zip \
    && ln -s /opt/oracle/instantclient_19_24 /opt/oracle/instantclient \
    && echo /opt/oracle/instantclient > /etc/ld.so.conf.d/oracle-instantclient.conf \
    && ldconfig

# Instalar extensiones de PHP necesarias
RUN docker-php-ext-install soap pdo_mysql

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instalar Symfony CLI
RUN wget https://get.symfony.com/cli/installer -O - | bash \
    && mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Crear un usuario no root
RUN useradd -m symfonyuser

# Copiar el archivo .env y la clave SSH
COPY .env /home/symfonyuser/.env
COPY ssh.key /home/symfonyuser/.ssh/id_rsa

# Asegurarse de que la clave SSH tenga los permisos correctos
RUN chmod 600 /home/symfonyuser/.ssh/id_rsa \
    && chown -R symfonyuser:symfonyuser /home/symfonyuser

USER symfonyuser

# Configurar SSH y clonar el repositorio
RUN eval $(ssh-agent -s) \
    && ssh-add /home/symfonyuser/.ssh/id_rsa \
    && ssh-keyscan github.com >> /home/symfonyuser/.ssh/known_hosts \
    && git clone $(grep REPO_URL /home/symfonyuser/.env | cut -d '=' -f2) /var/www/html

# Instalar dependencias de Symfony sin ejecutar scripts automáticos
WORKDIR /var/www/html
RUN composer install --no-scripts

# Crear las carpetas si no existen y dar permisos
USER root
RUN mkdir -p /var/www/html/var /var/www/html/public \
    && chown -R www-data:www-data /var/www/html/var /var/www/html/public

# Exponer el puerto 8000
EXPOSE 8000

# Iniciar el servidor Symfony
CMD ["symfony", "server:start", "--no-tls", "--port=8000"]
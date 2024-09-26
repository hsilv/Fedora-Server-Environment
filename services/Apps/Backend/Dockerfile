FROM php:8.2-apache-bullseye

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

# Copiar el archivo .env y la clave SSH
COPY .env /var/www/.env
COPY ssh.key /root/.ssh/id_rsa

# Asegurarse de que la clave SSH tenga los permisos correctos
RUN chmod 600 /root/.ssh/id_rsa

# Comandos para depuración
RUN echo "Contenido del archivo .env:" \
    && cat /var/www/.env \
    && echo "Contenido del archivo id_rsa:" \
    && cat /root/.ssh/id_rsa

RUN eval "$(ssh-agent -s)" \
    && ssh-add /root/.ssh/id_rsa

# Leer las variables del archivo .env y configurar SSH
RUN export $(cat /var/www/.env | xargs) \
    && ssh-keyscan github.com >> /root/.ssh/known_hosts \
    && git clone $REPO_URL /var/www/html

# Instalar dependencias de Symfony
WORKDIR /var/www/html
RUN composer update

# Crear las carpetas si no existen y dar permisos
RUN mkdir -p /var/www/html/var /var/www/html/public \
    && chown -R www-data:www-data /var/www/html/var /var/www/html/public

# Exponer el puerto 80
EXPOSE 80

# Iniciar Apache
CMD ["apache2-foreground"]
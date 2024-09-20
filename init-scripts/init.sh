#!/bin/bash

# Ejecutar todos los scripts en la carpeta init-scripts
for script in /init-scripts/*.sh; do
    echo "Ejecutando $script"
    /bin/bash $script || { echo "Error ejecutando $script"; exit 1; }
done

# Mantener el contenedor en ejecución
exec "$@"
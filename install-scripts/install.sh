#!/bin/bash

RED='\033[1;91m'
CYAN='\033[1;96m'
END='\033[0m'

# Ejecutar todos los scripts en la carpeta install-scripts, excepto install.sh
for script in ./install-scripts/*.sh; do
    if [ "$script" != "./install-scripts/install.sh" ]; then
        echo -e "${CYAN}Ejecutando $script${END}"
        chmod +x "$script"
        /bin/bash "$script" || { echo -e "${RED}Error ejecutando $script${END}"; exit 1; }
    fi
done
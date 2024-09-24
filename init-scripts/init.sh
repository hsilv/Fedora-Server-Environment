#!/bin/bash

RED='\033[1;91m'
CYAN='\033[1;96m'
PINK='\033[1;95m'
END='\033[0m'

# Ejecutar todos los scripts en la carpeta init-scripts
for script in ./init-scripts/*.sh; do
    if [ "$script" != "./init-scripts/init.sh" ]; then
        echo -e "${CYAN}Ejecutando $script${END}"
        chmod +x "$script"
        error_output=$(/bin/bash "$script" 2>&1)
        if [ $? -ne 0 ]; then
            echo -e "${RED}Error ejecutando $script:${END} ${PINK}$error_output${END}"
            exit 1
        fi
    fi
done
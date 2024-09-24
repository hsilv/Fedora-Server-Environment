
#!/bin/bash

GREEN='\033[1;92m'
RED='\033[1;91m'
END='\033[0m'

# * Entrypoint for the basic installation and initialization of the server

# Grant execution permissions to the scripts
chmod +x ./install-scripts/install.sh
chmod +x ./init-scripts/init.sh

# Run the installation scripts
echo -e "${GREEN}Running the installation scripts${END}"
./install-scripts/install.sh || { echo -e "${RED}Error running the installation scripts${END}"; exit 1; }

# Run the initialization scripts
echo -e "${GREEN}Running the initialization scripts${END}"
./init-scripts/init.sh || { echo -e "${RED}Error running the initialization scripts${END}"; exit 1; }
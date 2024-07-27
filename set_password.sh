#!/bin/bash

# Set Jupyter password
jupyter notebook password

# Extract the hashed password and save it to an environment variable
JUPYTER_HASHED_PASSWORD=$(grep -oP '(?<="hashed_password": ")[^"]*' /home/ubuntu/.jupyter/jupyter_server_config.json)

# Save the hashed password to a file that can be sourced later
echo "export JUPYTER_HASHED_PASSWORD='$JUPYTER_HASHED_PASSWORD'" > ~/.jupyter_password

echo "Password set and saved. Now run final_setup.sh to complete the configuration and launch Jupyter Lab."

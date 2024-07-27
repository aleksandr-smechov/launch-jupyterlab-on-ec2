#!/bin/bash

# initial_setup.sh

# Update and install packages
sudo apt update
sudo apt install -y python3-pip

# Install JupyterLab and Jupyter
pip3 install jupyterlab jupyter

# Downgrade packages to resolve errors
pip3 install markupsafe
pip3 install -U jsonschema

# Add ~/.local/bin to PATH
echo 'export PATH="$PATH:~/.local/bin/"' >> ~/.profile

# Set Jupyter password
jupyter notebook password

# Create self-signed certificate
mkdir -p ~/certs
cd ~/certs
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mycert.pem -out mycert.pem
sudo chown ubuntu:ubuntu mycert.pem
cd ~

# Generate Jupyter server configuration
jupyter-server --generate-config

# Update Jupyter server configuration
cat << EOF >> ~/.jupyter/jupyter_server_config.py
c = get_config()
c.ServerApp.certfile = u'/home/ubuntu/certs/mycert.pem'
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 8888
EOF

echo "Initial setup complete. Please reboot the instance and then run launch_jupyter.sh"

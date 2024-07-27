#!/bin/bash

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

# Launch Jupyter Lab
nohup jupyter lab --no-browser --NotebookApp.iopub_data_rate_limit=1.0e10 &

echo "Jupyter Lab has been configured and launched. You can now connect to it using your browser."

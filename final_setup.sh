#!/bin/bash

# Source the saved Jupyter password
source ~/.jupyter_password

# Add ~/.local/bin to PATH if not already there
if ! grep -q "export PATH=\"\$PATH:~/.local/bin/\"" ~/.profile; then
    echo 'export PATH="$PATH:~/.local/bin/"' >> ~/.profile
    source ~/.profile
fi

# Downgrade packages to resolve errors
pip3 install markupsafe
pip3 install -U jsonschema

# Create self-signed certificate
mkdir -p ~/certs
cd ~/certs
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mycert.pem -out mycert.pem -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"
sudo chown ubuntu:ubuntu mycert.pem
cd ~

# Generate Jupyter server configuration
jupyter-server --generate-config

# Update Jupyter server configuration
cat << EOF >> ~/.jupyter/jupyter_server_config.py
c = get_config()
c.ServerApp.certfile = u'/home/ubuntu/certs/mycert.pem'
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.password = u'$JUPYTER_HASHED_PASSWORD'
c.ServerApp.port = 8888
EOF

# Launch Jupyter Lab
nohup jupyter lab --no-browser --NotebookApp.iopub_data_rate_limit=1.0e10 &

echo "Jupyter Lab has been configured and launched. You can now connect to it using your browser."

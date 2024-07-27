#!/bin/bash

# Check if this is a new instance (you can adjust this check as needed)
if [ ! -f /home/ubuntu/.jupyter_setup_complete ]; then
    # Update and install packages
    sudo apt update
    sudo apt install -y python3-pip
fi

# Install JupyterLab and Jupyter
pip3 install jupyterlab
pip3 install jupyter

# Mark setup as complete
touch /home/ubuntu/.jupyter_setup_complete

echo "Initial setup complete. Please reboot the instance and then run after_reboot.sh"

# Jupyter Lab Setup on AWS EC2 with GPU Support

This guide provides instructions for setting up Jupyter Lab on an AWS EC2 instance with GPU support. The setup is divided into three scripts for easier management and flexibility.

## Prerequisites

- An AWS account with EC2 access
- An EC2 instance with GPU support (recommended: g4dn.xlarge or better)
- Deep Learning AMI (recommended: Deep Learning Base OSS Nvidia Driver GPU AMI (Ubuntu 22.04))

## Setup Instructions

### 1. Initial Setup

1. Connect to your EC2 instance via SSH.

2a. Either copy/paste the following scripts to your instance:
```bash
   - before_reboot.sh
   - set_password.sh
   - final_setup.sh
```

2b. Or clone this repo and copy the scripts from there:
```bash
   - git clone https://github.com/aleksandr-smechov/launch-jupyterlab-on-ec2.git
   - cd launch-jupyterlab-on-ec2
   - cp * ~/
   - cd ~
```

4. Make the scripts executable:
`chmod +x before_reboot.sh set_password.sh final_setup.sh`

5. Run the initial setup script:
`./before_reboot.sh`

6. Once the script completes, reboot your instance:
`sudo reboot`

### 2. Set Jupyter Password

1. After the reboot, reconnect to your EC2 instance.

2. Run the password setting script:
`./set_password.sh`

3. When prompted, enter and confirm a password for Jupyter. This password will be used to access your Jupyter Lab instance.

### 3. Final Setup and Launch

1. Run the final setup script:
`./final_setup.sh`

2. This script will complete the configuration and launch Jupyter Lab in the background.

## Accessing Jupyter Lab

1. In your local machine's web browser, navigate to:
`https://<your-ec2-public-dns>:8888`

Replace `<your-ec2-public-dns>` with your EC2 instance's public DNS.

2. You may see a security warning due to the self-signed certificate. Proceed anyway (you can add an exception in your browser).

3. Enter the password you set during the setup process.

## Security Considerations

- Ensure that your EC2 security group allows inbound traffic on port 8888.
- For production use, consider setting up HTTPS with a proper SSL certificate.
- Regularly update your EC2 instance and installed packages.

## Troubleshooting

- If Jupyter Lab doesn't start, check the `nohup.out` file for error messages:
`cat nohup.out`

- Verify that the security group for your EC2 instance allows inbound traffic on port 8888.

## Script Descriptions

1. `before_reboot.sh`: Installs necessary packages and Jupyter.
2. `set_password.sh`: Sets up the Jupyter password and saves it securely.
3. `final_setup.sh`: Configures Jupyter and launches Jupyter Lab.

## Additional Resources

- [Jupyter Documentation](https://jupyter.org/documentation)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)

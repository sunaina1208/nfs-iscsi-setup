#!/bin/bash
# Define the service file path
SERVICE_FILE="/lib/systemd/system/nfs-common.service"

# Function to check for errors
check_error() {
    if [ $? -ne 0 ]; then
        echo "An error occurred while executing the last command."
        exit 1
    fi
}

# Remove the nfs-common service file
echo "Removing nfs-common.service file..."
sudo rm "$SERVICE_FILE"
check_error

# Reload systemd daemon
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload
check_error

# Enable the nfs-common service
echo "Enabling nfs-common.service..."
sudo systemctl enable nfs-common.service
check_error

# Start the nfs-common service
echo "Starting nfs-common.service..."
sudo systemctl start nfs-common.service
check_error

# Check the status of the nfs-common service
echo "Checking the status of nfs-common"
systemctl status nfs-common

# Notify script completion
echo "NFS ENABLED SUCCESSFULLY"

#!/bin/bash

# Define a function to check if a command was successful
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error: Command failed."
        exit 1
    fi
}

echo "Starting setup..."

# Install .deb packages
echo "Installing .deb packages..."
sudo dpkg -i *.deb
check_command

# Check installed packages
echo "Checking installed packages..."
dpkg -l open-iscsi lsscsi sg3-utils multipath-tools scsitools
check_command

# Update iscsid.conf
echo "Updating /etc/iscsi/iscsid.conf..."
sudo sed -i 's/^\(node.session.scan\).*/\1 = manual/' /etc/iscsi/iscsid.conf
check_command

# Write configuration to /etc/multipath.conf
echo "Writing configuration to /etc/multipath.conf..."
sudo tee /etc/multipath.conf > /dev/null <<-'EOF'
defaults {
    user_friendly_names yes
    find_multipaths no
}
EOF
check_command

# Discover iSCSI targets
echo "Discovering iSCSI targets..."
sudo iscsiadm -m discovery -t sendtargets -p 192.168.100.202
check_command

# Login to iSCSI target
echo "Logging into iSCSI target..."
sudo iscsiadm -m node -T iqn.2005-10.org.freenas.ctl:iscsidevice01 -p 192.168.100.202 --login
check_command

# List iSCSI sessions
echo "Listing iSCSI sessions..."
sudo iscsiadm -m session
check_command

# Update iSCSI node startup setting
echo "Updating iSCSI node startup setting..."
sudo iscsiadm -m node -T iqn.2005-10.org.freenas.ctl:iscsidevice01 -p 192.168.100.202 --op update -n node.startup -v automatic
check_command
# Enable and start multipathd service
echo "Enabling and starting multipathd service..."
sudo systemctl enable --now multipathd.service
check_command

# Restart multipath-tools service
echo "Restarting multipath-tools service..."
sudo service multipath-tools restart
check_command

# Check multipath-tools service status
echo "Checking multipath-tools service status..."
sudo systemctl status multipath-tools
check_command

# Enable and start open-iscsi service
echo "Enabling and starting open-iscsi service..."
sudo systemctl enable --now open-iscsi.service
check_command

#Restart open-iscsi service
echo "Restarting open-iscsi service...."
sudo systemctl restart open-iscsi

# Check open-iscsi service status
echo "Checking open-iscsi service status..."
sudo systemctl status open-iscsi
check_command

echo "ISCSI INSTALLATION COMPLETED!"

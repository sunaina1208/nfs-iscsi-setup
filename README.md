This repository contains shell scripts to automate the setup of NFS and iSCSI on Ubuntu systems. These scripts simplify the configuration process for network-based storage solutions, making it easier to prepare your infrastructure.

Scripts
enable_nfs.sh
This script configures and enables NFS (Network File System) on the server. It sets up the necessary services and exports the specified directories for network access.

install_iscsi.sh
This script installs and configures iSCSI (Internet Small Computer Systems Interface) on the server. It ensures that iSCSI initiators and related services are properly set up for connecting to networked storage devices.

Requirements
Operating System: Ubuntu
Privileges: Root or sudo access is required to run these scripts.
Dependencies: Ensure that the necessary packages for NFS and iSCSI are available on your system.

Installation and Usage
Clone the Repository:
git clone https://github.com/yourusername/nfs-iscsi-setup.git
cd nfs-iscsi-setup

Run the Scripts:

To enable NFS, execute:
sudo ./enable_nfs.sh

To install and configure iSCSI, execute:
sudo ./install_iscsi.sh
Ensure that you review and modify the scripts as needed to fit your specific configuration requirements.

Configuration
NFS Configuration: The enable_nfs.sh script exports directories based on hardcoded values or configurations within the script. You may need to adjust these values according to your environment.

iSCSI Configuration: The install_iscsi.sh script installs iSCSI utilities and may require additional configuration for your iSCSI targets. Ensure your iSCSI target information is correctly provided in the script if needed.

Example
Below is an example of how to use the scripts to set up NFS and iSCSI:

Clone the repository:

git clone https://github.com/yourusername/nfs-iscsi-setup.git
Navigate to the script directory:
cd nfs-iscsi-setup
Make the scripts executable:
chmod +x enable_nfs.sh install_iscsi.sh
Run the NFS setup script:
sudo ./enable_nfs.sh
Run the iSCSI setup script:
sudo ./install_iscsi.sh
Troubleshooting
Script Errors: Ensure that all necessary packages and dependencies are installed on your system. Review the script output for any errors or missing configurations.

Permissions: Make sure you have the required root or sudo privileges to execute the scripts.


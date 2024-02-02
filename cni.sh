#!/bin/bash

echo -e "\e[1;35m   _____ _   _ _____                       \e[0m"
echo -e "\e[0;35m  / ____| \\ | |_   _|                      \e[0m"
echo -e "\e[1;36m | |    |  \\| | | |                        \e[0m"
echo -e "\e[0;36m | |    | . \` | | |                        \e[0m"
echo -e "\e[1;34m | |____| |\\  |_| |_                       \e[0m"
echo -e "\e[0;34m  \\_____|_|\\_\\|_____|  _____ _____ _______ \e[0m"
echo -e "\e[1;32m  / ____|/ ____|  __ \\|_   _|  __ \\__   __| \e[0m"
echo -e "\e[0;32m | (___ | |    | |__) | | | | |__) | | |    \e[0m"
echo -e "\e[1;33m  \\___ \\| |    |  _  /  | | |  ___/  | |    \e[0m"
echo -e "\e[0;33m  ____) | |____| | \\ \\ _| |_| |      | |    \e[0m"
echo -e "\e[0;31m |_____/ \\_____|_|  \\_\\_____|_|      |_|    \e[0m"
echo -e ""
echo -e "\e[32m          By Jarukrit Sripaploen\e[0m"
echo -e "\e[0;31m        https://jarukrit.net/cni.sh \e[0m"
echo -e ""

# Forcing IPv4 on APT
echo -e "\e[0;34m[CNI-Script] Setting IPv4 repo as apt perference\e[0m"
echo "Acquire::ForceIPv4 \"true\";" > /etc/apt/apt.conf.d/99force-ipv4

# Update package information
echo -e "\e[0;34m[CNI-Script] Cleaning package cache\e[0m"
apt clean

# Update package information
echo -e "\e[0;34m[CNI-Script] Updating package information\e[0m"
apt update

# Install tftpd-hpa
echo -e "\e[0;34m[CNI-Script] Installing tftpd-hpa\e[0m"
apt install -y tftpd-hpa

# Check the status of tftpd-hpa service
if systemctl is-active --quiet tftpd-hpa; then
    echo -e "\e[1;32m[CNI-Script] tftpd-hpa service is active.\e[0m"
else
    echo -e "\e[1;31m[CNI-Script] tftpd-hpa service is not active. Aborting.\e[0m"
    exit 1
fi

# Edit /etc/default/tftpd-hpa
echo -e "\e[0;34m[CNI-Script] Editing /etc/default/tftpd-hpa\e[0m"
cat <<EOF > /etc/default/tftpd-hpa
# /etc/default/tftpd-hpa
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/tftp" 
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure --create"
EOF

# Create /tftp directory and set ownership
echo -e "\e[0;34m[CNI-Script] Creating /tftp directory and setting ownership\e[0m"
mkdir /tftp
chown tftp:tftp /tftp

# Restart tftpd-hpa service
echo -e "\e[0;34m[CNI-Script] Restarting tftpd-hpa service\e[0m"
systemctl restart tftpd-hpa

# Check the status of tftpd-hpa service after restart
if systemctl is-active --quiet tftpd-hpa; then
    echo -e "\e[1;32m[CNI-Script] tftpd-hpa service is active after restart.\e[0m"
else
    echo -e "\e[1;31m[CNI-Script] tftpd-hpa service is not active after restart. Aborting.\e[0m"
    exit 1
fi

# Install openssh-server
echo -e "\e[0;34m[CNI-Script] Installing openssh-server\e[0m"
apt install -y openssh-server

# Check the status of sshd service
if systemctl is-active --quiet sshd; then
    echo -e "\e[1;32m[CNI-Script] sshd service is active.\e[0m"
    # echo -e "\e[31m            _       _        _____    ____   _   _  ______  _ \e[0m"
    # echo -e "\e[31m     /\    | |     | |      |  __ \\  / __ \\ | \\ | ||  ____|| |\e[0m"
    # echo -e "\e[31m    /  \\   | |     | |      | |  | || |  | ||  \\| || |__   | |\e[0m"
    # echo -e "\e[31m   / /\\ \\  | |     | |      | |  | || |  | || . \` ||  __|  | |\e[0m"
    # echo -e "\e[31m  / ____ \\ | |____ | |____  | |__| || |__| || |\\  || |____ |_|\e[0m"
    # echo -e "\e[31m /_/    \\_\\|______||______| |_____/  \\____/ |_| \\_||______|(_)\e[0m"
    # echo -e ""
    clear
	echo -e "\e[1;32m[CNI-Script] COMPLETED SUCCESSFULLY\e[0m"
	# echo -e "\e[1;33m[CNI-Script] Donate at 090-546-1646 PromptPay\e[0m"     
else
    echo -e "\e[1;31m[CNI-Script] sshd service is not active.\e[0m"
fi

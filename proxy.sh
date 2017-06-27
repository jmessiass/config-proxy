#!/bin/bash
# PROXY SETTINGS

# Get ip used on proxy
echo -n "IP: "
read ip

# Get port used on proxy
echo -n "Port: "
read port

# Get password used on proxy
echo -n "User: "
read user

# Get password used on proxy
echo -n "Password: "
read password

# CONFIG FILE /etc/wgetrc
echo "https_proxy = http://$ip:$port/" | sudo tee /etc/wgetrc -a
echo "http_proxy = http://$ip:$port/" | sudo tee /etc/wgetrc -a
echo "ftp_proxy = http://$ip:$port/" | sudo tee /etc/wgetrc -a
echo "use_proxy = on" | sudo tee /etc/wgetrc -a
echo "proxy_user = $user" | sudo tee /etc/wgetrc -a
echo "proxy_passwd = $password" | sudo tee /etc/wgetrc -a

# CONFIG FILE /etc/apt/apt.conf
echo "Acquire::http::proxy \"http://$user:$password@$ip:$port/\";" | sudo tee /etc/apt/apt.conf -a
echo "Acquire::https::proxy \"http://$user:$password@$ip:$port/\";" | sudo tee /etc/apt/apt.conf -a

# CONFIG FILE /etc/profile
echo "export http_proxy=http://$user:$password@$ip:$port" | sudo tee /etc/profile -a
echo "export https_proxy=http://$user:$password@$ip:$port" | sudo tee /etc/profile -a
echo "export ftp_proxy=http://$user:$password@$ip:$port" | sudo tee /etc/profile -a
echo "export no_proxy=127.0.0.1,localhost" | sudo tee /etc/profile -a

# REBOOT SYSTEM
sudo reboot

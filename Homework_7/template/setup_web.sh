#! /bin/bash
set -e -x
sudo apt update 
sudo apt upgrade -y 
sudo apt install apache2 -y
sudo mkdir /etc/apache2/ssl
sudo sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt -subj '/CN=localhost/O=ProgKyivAcademy'
sudo a2enmod ssl
sudo systemctl restart apache2
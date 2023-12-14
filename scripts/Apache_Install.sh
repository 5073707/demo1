#! / bin/bash

#update, install, and start the Apache
sudo apt update && sudo apt upgrade -y

sudo apt install apache2 -y

sudo systemctl status apache2
sudo systemctl restart apache2

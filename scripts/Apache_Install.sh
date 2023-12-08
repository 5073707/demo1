#! / bin/bash

#update, install, and start the Apache

sudo yum update -y
sudo yum install httpd
sudo systemctl enable httpd
sudo systemctl start httpd

#message to create index.html file
echo "<h1>Keep pushing green!<h1>" >> /var/www/html/index.html



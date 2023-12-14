#!/bin/bash

# Update package and install 
sudo apt update && sudo apt upgrade -y
sudo apt install fontconfig openjdk-17-jre
sudo apt install maven -y

# Add the Jenkins repository key to authenticate packages
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add the Jenkins repository source to package sources
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null


# Install Jenkins
sudo apt-get update
sudo apt-get install jenkins


# Enable Jenkins as a service to start on system boot
sudo systemctl enable jenkins

# Start Jenkins service
sudo systemctl start jenkins


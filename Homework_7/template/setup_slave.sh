#! /bin/bash
set -e -x
sudo apt update 
sudo apt upgrade -y 
sudo apt install default-jre -y
sudo apt install default-jdk -y

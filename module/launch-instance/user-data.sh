#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo ufw allow 'Nginx HTTP'
yes | sudo ufw enable
cd /var/www
sudo mkdir tutorial
cd tutorial
sudo "${EDITOR:-vi}" index.html
#!/bin/bash
sudo apt update
sudo apt install nginx -y
git clone https://<username>:<git-token>@github.com/<username>/<repository>.git
rm -rf /var/www/html/index.debian.html
cd <path/to/directoryOfHTML>
sudo mv index.html /var/www/html/

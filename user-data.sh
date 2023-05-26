#!/bin/bash
sudo apt update
sudo apt install nginx -y
git clone https://jjma22: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@github.com/jjma22/ce-terraform-project.git
rm -rf /var/www/html/index.debian.html
cd ce-terraform-project/module/launch-instance/
sudo mv index.html /var/www/html/

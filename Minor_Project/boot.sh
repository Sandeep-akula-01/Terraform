#!/bin/bash

sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "This is Sandeep From Facebook Webpage Created using Terraform script" > /var/www/html/index.html

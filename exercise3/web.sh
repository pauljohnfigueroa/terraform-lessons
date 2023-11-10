#!/bin/bash

yum install wget unzip httpd -y
systemctl start httpd
systemctl enable httpd
wget https://www.tooplate.com/zip-templates/2131_wedding_lite.zip
unzip -o 2131_wedding_lite.zip
cp -r 2131_wedding_lite/* /var/www/html
systemctl restart httpd
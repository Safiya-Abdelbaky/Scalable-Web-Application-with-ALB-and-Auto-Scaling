#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Welcome to Scalable Web Application with ALB and Auto Scaling - Deployed Successfully!</h1>" > /var/www/html/index.html

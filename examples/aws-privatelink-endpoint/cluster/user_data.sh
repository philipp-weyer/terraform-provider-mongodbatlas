#!/bin/sh -xe
sudo echo -e "[mongodb-org-6.0]  \nname=MongoDB Repository \nbaseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/6.0/x86_64/ \ngpgcheck=1 \nenabled=1 \ngpgkey=https://www.mongodb.org/static/pgp/server-6.0.asc" >> /etc/yum.repos.d/mongodb-org-6.0.repo

sudo yum install -y mongodb-org

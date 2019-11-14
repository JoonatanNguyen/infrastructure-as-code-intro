#!/bin/bash

curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
sudo apt update
sudo apt --assume-yes install nodejs
sudo npm i -g pm2 
cd /home/ubuntu/webserver
npm install
sudo pm2 delete app >& /dev/null || true
sudo pm2 start app.js

#!/bin/bash

sudo apt update
sudo apt --assume-yes install nodejs
sudo apt --assume-yes install npm
sudo npm i -g pm2 
cd /home/ubuntu/webserver
npm install
sudo pm2 delete app >& /dev/null || true
sudo pm2 start app.js

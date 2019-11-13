#!/bin/bash

sudo apt update
sudo apt --assume-yes install nodejs
sudo apt --assume-yes install npm
sudo npm i -g pm2 
mkdir /home/ubuntu/webserver >& /dev/null || true
cd /home/ubuntu/webserver
cat <<'EOF' > package.json
${packageJson}
EOF
cat <<'EOF' > app.js
${appJs}
EOF
npm install
sudo pm2 delete app >& /dev/null || true
sudo pm2 start app.js

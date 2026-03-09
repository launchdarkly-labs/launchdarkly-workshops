#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get -y update

# Install tools
mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_24.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /etc/apt/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt-get -y update
apt-get -y install unzip jq git curl gnupg ca-certificates terraform vim

# Cleanup and install NodeJS
apt-get install -y nodejs
npm install -g npm@latest

# clone the Terraform code to generate user
mkdir -p /opt/ld
cd /opt/ld
git clone https://github.com/launchdarkly-labs/terraform-ld-student.git
cd /opt/ld/terraform-ld-student
terraform init

# clone our code repo
cd /opt/ld
git clone https://github.com/launchdarkly-labs/ld-workshop-coffee-shop.git
cd /opt/ld/ld-workshop-coffee-shop
# npm run build
npm install
cd /root

# Create Code Server startup script
cat <<-EOF > /etc/systemd/system/coffeeshop.service
[Unit]
Description=Coffee Shop
After=network.target
StartLimitIntervalSec=0
[Service]
Environment=NODE_PORT=3000
Type=simple
Restart=always
RestartSec=1
User=root
WorkingDirectory=/opt/ld/ld-workshop-coffee-shop
ExecStart=node app.js
[Install]
WantedBy=multi-user.target
EOF

# Start Coffee Shop app
systemctl enable coffeeshop
systemctl start coffeeshop

# Install code editor
mkdir -p /root/.local/share/code-server/User

cat > /root/.local/share/code-server/User/settings.json <<-EOF
{
    "workbench.colorTheme": "Default Dark+",
    "workbench.startupEditor": "none",
    "security.workspace.trust.enabled": false,
}
EOF

curl -fsSL https://code-server.dev/install.sh | sh

# Create Code Server startup script
cat <<-EOF > /etc/systemd/system/code-server.service
[Unit]
Description=Code Server
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=/usr/bin/code-server --host 0.0.0.0 --port 8080 --auth none /opt/ld/ld-workshop-coffee-shop

[Install]
WantedBy=multi-user.target
EOF

# Start Code Server
systemctl enable code-server
systemctl start code-server

# code-server --install-extension ms-python.python --user-data-dir /user-data

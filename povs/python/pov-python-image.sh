#!/bin/bash

###########################
# Versions to keep updated
# 
# * NodeJS
###########################


export HOME=/root
export DEBIAN_FRONTEND=noninteractive
apt-get -y update

# Install tools
mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /etc/apt/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
apt-get -y update
apt-get -y autoremove
apt-get -y install unzip jq git curl gnupg ca-certificates terraform vim

# Cleanup and install NodeJS
apt-get install -y nodejs
npm install -g npm@latest

# Install Python
apt-get -y install pip
ln -s /usr/bin/python3 /usr/bin/python
pip install launchdarkly-server-sdk flask flask_cors

# Install Python App
######################
mkdir -p /opt/python
cd /opt/python
git clone https://github.com/launchdarkly-labs/ld-sample-app-python.git
cd ld-sample-app-python

######################

# clone the Terraform code to generate user
mkdir -p /opt/ld
cd /opt/ld
git clone https://github.com/kevincloud/terraform-ld-student.git
cd /opt/ld/terraform-ld-student
terraform init

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
cat > /etc/systemd/system/code-server.service <<-EOF
[Unit]
Description=Code Server
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=/usr/bin/code-server --host 0.0.0.0 --port 8080 --auth none /opt/python/

[Install]
WantedBy=multi-user.target
EOF

# Start Code Server
systemctl enable code-server
systemctl start code-server

# code-server --install-extension ms-python.python --user-data-dir /user-data

mkdir /opt/ld/flag
cat > /opt/ld/flag/main.tf <<-EOF
terraform {
  required_providers {
    launchdarkly = {
      source  = "launchdarkly/launchdarkly"
      version = "~>2.15"
    }
  }
}

variable "project_key" {
}

provider "launchdarkly" {
}

resource "launchdarkly_feature_flag" "release_storefront_flag" {
  project_key = var.project_key
  key         = "test-flag"
  name        = "Test Flag"

  variation_type = "boolean"

  variations {
    value = "true"
    name  = "True"
  }
  variations {
    value = "false"
    name  = "False"
  }

  client_side_availability {
    using_environment_id = true
    using_mobile_key     = false
  }

  defaults {
    on_variation  = 0
    off_variation = 1
  }

  tags = [
    "managed-by-terraform"
  ]
}

EOF

cd /opt/ld/flag
terraform init

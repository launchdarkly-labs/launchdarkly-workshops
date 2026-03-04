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
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt-get -y update
apt-get -y install unzip jq git curl gnupg ca-certificates terraform vim

# Cleanup and install NodeJS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24

# Install Python
ln -s /usr/bin/python3 /usr/bin/python
apt-get -y install python3-venv python3-flask python3-flask-cors python3-pip python3-dotenv
pip install launchdarkly-server-sdk --break-system-packages

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

cd /root
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

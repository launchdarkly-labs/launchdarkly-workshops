#!/bin/bash

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
apt-get -y install nuget unzip jq git curl gnupg ca-certificates terraform vim awscli nginx

# Cleanup and install NodeJS
apt-get install -y nodejs
npm install -g npm@latest

# Install Java / kotlin / maven / gradle
apt-get -y install openjdk-19-jdk-headless kotlin maven
cd /opt
wget https://services.gradle.org/distributions/gradle-8.7-bin.zip
unzip gradle-8.7-bin.zip
ln -s /opt/gradle-8.7 /opt/gradle
export GRADLE_HOME=/opt/gradle
export PATH=${GRADLE_HOME}/bin:${PATH}
echo "export GRADLE_HOME=/opt/gradle" >> /root/.profile
echo "export PATH=${GRADLE_HOME}/bin:${PATH}" >> /root/.profile
echo "export GRADLE_HOME=/opt/gradle" >> /root/.bashrc
echo "export PATH=${GRADLE_HOME}/bin:${PATH}" >> /root/.bashrc
rm gradle-8.7-bin.zip

# Install the Android SDK Cmdline tools
apt-get update
apt-get install -y android-sdk
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
mv commandlinetools-linux-11076708_latest.zip /usr/lib/android-sdk/
cd /usr/lib/android-sdk/
unzip commandlinetools-linux-11076708_latest.zip
export ANDROID_HOME="/usr/lib/android-sdk"
echo "export ANDROID_HOME=\"/usr/lib/android-sdk\"" >> /root/.profile
echo "export ANDROID_HOME=\"/usr/lib/android-sdk\"" >> /root/.bashrc
rm commandlinetools-linux-11076708_latest.zip

# Install Android SDK platform 34
wget "https://dl.google.com/android/repository/platform-34-ext10_r01.zip"
mv platform-34-ext10_r01.zip /usr/lib/android-sdk/platforms
cd /usr/lib/android-sdk/platforms
unzip platform-34-ext10_r01.zip
rm platform-34-ext10_r01.zip

# accept the licenses
cd /usr/lib/android-sdk/cmdline-tools/bin
yes | ./sdkmanager --sdk_root=/usr/lib/android-sdk --licenses

# setup sample app
mkdir -p /opt/java
cd /opt/java
git clone https://github.com/kevincloud/test-calculator-android.git
echo "sdk.dir=/usr/lib/android-sdk" > /opt/java/test-calculator-android/local.properties
cd /opt/java/test-calculator-android
gradle wrapper
gradle build

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
ExecStart=/usr/bin/code-server --host 0.0.0.0 --port 8080 --auth none /opt/java/

[Install]
WantedBy=multi-user.target
EOF

# Start Code Server
systemctl enable code-server
systemctl start code-server

# Install Kotlin extension
/usr/bin/code-server --install-extension fwcd.kotlin
# code-server --install-extension ms-python.python --user-data-dir /user-data

cd /opt/java
git clone https://github.com/kevincloud/mobile-control-app.git

cat <<-EOF > /etc/nginx/sites-available/default
server {
        listen 80 default_server;
        root /opt/java/mobile-control-app;
        server_name _;
        location / {
            try_files \$uri \$uri/ =404;
        }
}
EOF

service nginx restart



mkdir /opt/ld/flag
cat <<-EOF > /opt/ld/flag/main.tf
terraform {
  required_providers {
    launchdarkly = {
      source  = "launchdarkly/launchdarkly"
      version = "~>2.15"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

variable "project_key" {
}

variable "sandbox_id" {
}

provider "aws" {
  region = "us-east-1"
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

resource "aws_s3_bucket" "appdevbucket" {
  bucket = "mobile-app-dev-\${var.sandbox_id}"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "appdevbucket" {
  bucket = aws_s3_bucket.appdevbucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "appdevbucket" {
  bucket = aws_s3_bucket.appdevbucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "appdevbucket" {
  bucket = aws_s3_bucket.appdevbucket.id
  acl    = "public-read"

  depends_on = [
    aws_s3_bucket_public_access_block.appdevbucket,
    aws_s3_bucket_ownership_controls.appdevbucket
  ]
}

resource "aws_s3_bucket_policy" "publicbucket" {
  bucket = aws_s3_bucket.appdevbucket.id
  policy = data.aws_iam_policy_document.publicbucket.json
}

data "aws_iam_policy_document" "publicbucket" {
  statement {
    effect = "Allow"
    principals {
      type = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.appdevbucket.arn,
      "\${aws_s3_bucket.appdevbucket.arn}/*",
    ]
  }
}

resource "aws_iam_user" "appdevuser" {
  name = "mobile-s3-user-\${var.sandbox_id}"
}

resource "aws_iam_access_key" "appdevuser_creds" {
  user = aws_iam_user.appdevuser.name
}

data "aws_iam_policy_document" "appdevuser_pdoc" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::mobile-app-dev-\${var.sandbox_id}",
                 "arn:aws:s3:::mobile-app-dev-\${var.sandbox_id}/*"]
  }
}

resource "aws_iam_user_policy" "appdevuser_policy" {
  name   = "mobile-s3-policy-\${var.sandbox_id}"
  user   = aws_iam_user.appdevuser.name
  policy = data.aws_iam_policy_document.appdevuser_pdoc.json
}

output "bucket_name" {
  value = aws_s3_bucket.appdevbucket.bucket
}

output "access_key_id" {
  value = aws_iam_access_key.appdevuser_creds.id
}

output "access_secret" {
  sensitive = true
  value = aws_iam_access_key.appdevuser_creds.secret
}
EOF

cd /opt/ld/flag
terraform init

# Secure Apache Setup Guide
## Initial Setup
### Updateing and Installing Required Tools
- sudo apt update && sudo apt upgrade
- sudo apt install docker.io
- ### Docker compose install
  - mkdir -p ~/.docker/cli-plugins/
  - wget -O ~/.docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.32.1/docker-compose-linux-x86_64
  - chmod +x ~/.docker/cli-plugins/docker-compose
### Creating the Directories & Downloading Files
- sudo mkdir /apache_webserver/setup -p
- cd /apache_webserver/setup
- sudo wget -O 000-default.conf "https://github.com/CalebC44/Personal-Projects/blob/main/Secure%20Web%20Server%20Deployment%20Scripts/Apache-Files/000-default.conf"
- sudo wget -O default-ssl.conf "https://github.com/CalebC44/Personal-Projects/blob/main/Secure%20Web%20Server%20Deployment%20Scripts/Apache-Files/default-ssl.conf"
- sudo wget -O security2.conf "https://github.com/CalebC44/Personal-Projects/blob/main/Secure%20Web%20Server%20Deployment%20Scripts/Apache-Files/security2.conf"
- sudo wget -O DockerFile "https://github.com/CalebC44/Personal-Projects/blob/main/Secure%20Web%20Server%20Deployment%20Scripts/Apache-Files/DockerFile"

### Downloading Modsecurity Files
- sudo wget https://github.com/coreruleset/coreruleset/releases/download/v4.9.0/coreruleset-4.9.0-minimal.tar.gz
- tar -xzf coreruleset-4.9.0-minimal.tar.gz
- sudo rm coreruleset-4.9.0-minimal.tar.gz 

## Steps
### Step 1: Building the Apache Container
- docker build -t apache .
### Step 2: Pulling the Image
- docker pull linuxserver/fail2ban:latest
### Step 3: Create Directory for fail2ban
- mkdir -p /docker/fail2ban/log/
### Step 4: Docker compose use
- docker compose up -d --build

### Step 5: update jail.local 
Replace the jail.local file with the one in this folder.

### Step 6: Commands
- docker exec -it fail2ban fail2ban-client status
- docker exec -it fail2ban fail2ban-client status apache-modsecurity
- docker exec -it fail2ban fail2ban-client set JAIL unbanip IP_ADDRESS
- docker exec -it fail2ban /bin/bash
- Whitelist ip:
- sed -i '/^ignoreip/s/$/ <NEW_IP>/' /webserver/fail2ban/fail2ban/jail.local

### Step 7: Firewall: 
- ufw allow 80/tcp
- ufw allow 443/tcp
- ufw allow 9000/tcp 






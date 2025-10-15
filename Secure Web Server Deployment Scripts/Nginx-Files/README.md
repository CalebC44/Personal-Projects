# Secure Nginx Setup Guide
## Initial Setup
### Updateing and Installing Required Tools
- sudo apt update && sudo apt upgrade
- sudo apt install docker.io
- ### Docker compose install
  - sudo mkdir -p ~/.docker/cli-plugins/
  - sudo wget -O ~/.docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.32.1/docker-compose-linux-x86_64
  - sudo chmod +x ~/.docker/cli-plugins/docker-compose
### Creating the Directories & Downloading Files
- sudo mkdir /nginx_webserver/setup -p
- cd /nginx_webserver
- sudo wget -P ./setup https://raw.githubusercontent.com/CalebC44/Personal-Projects/refs/heads/main/Secure%20Web%20Server%20Deployment%20Scripts/Nginx-Files/Dockerfile
- sudo wget -P ./setup https://raw.githubusercontent.com/CalebC44/Personal-Projects/refs/heads/main/Secure%20Web%20Server%20Deployment%20Scripts/Nginx-Files/Default
- sudo wget -P ./setup https://raw.githubusercontent.com/CalebC44/Personal-Projects/refs/heads/main/Secure%20Web%20Server%20Deployment%20Scripts/Nginx-Files/docker-compose.yml
- sudo wget -P ./setup https://raw.githubusercontent.com/CalebC44/Personal-Projects/refs/heads/main/Secure%20Web%20Server%20Deployment%20Scripts/Nginx-Files/jail.local
- sudo wget -P ./setup https://raw.githubusercontent.com/CalebC44/Personal-Projects/refs/heads/main/Secure%20Web%20Server%20Deployment%20Scripts/Nginx-Files/nginx-modsecurity.conf
- sudo wget -P ./setup https://raw.githubusercontent.com/CalebC44/Personal-Projects/refs/heads/main/Secure%20Web%20Server%20Deployment%20Scripts/Nginx-Files/nginx.conf

### Downloading Modsecurity Files
- sudo wget https://github.com/coreruleset/coreruleset/releases/download/v4.9.0/coreruleset-4.9.0-minimal.tar.gz
- tar -xzf coreruleset-4.9.0-minimal.tar.gz
- sudo rm coreruleset-4.9.0-minimal.tar.gz
  
## Steps: 
### Step 1: Docker compose install
- mkdir -p ~/.docker/cli-plugins/
- wget -O ~/.docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.32.1/docker-compose-linux-x86_64
- chmod +x ~/.docker/cli-plugins/docker-compose

### Step 2: Pulling the Image
- docker pull linuxserver/fail2ban:latest
  
###  Step 3: Create Directory for fail2ban
- mkdir -p /webserver/fail2ban/config
- mkdir -p /webserver/fail2ban/log/

### Step 4: Docker compose use
- docker compose up -d --build 
- docker compose stop
- docker compose down

### Step 5: Fail2ban Commands
- docker exec -it fail2ban fail2ban-client status
- docker exec -it fail2ban fail2ban-client status nginx-modsecurity
- docker exec -it fail2ban fail2ban-client set JAIL unbanip IP_ADDRESS
- docker exec -it fail2ban /bin/bash
- Whitelist ip:
  - sed -i '/^ignoreip/s/$/ <NEW_IP>/' /webserver/fail2ban/fail2ban/jail.local
 
### Step 6: Firewall: 
- ufw allow 80/tcp
- ufw allow 443/tcp
- ufw allow 9000/tcp 




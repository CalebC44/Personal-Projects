# Setting up the Graylog Server
- Reference: [Lawrence Systems](https://www.youtube.com/watch?v=DwYwrADwCmg)
### Step 1: Set a Default Time Zone
- sudo timedatectl set-timezone UTC
### Step 2: Install Necessary Files 
- sudo apt update && sudo apt install docker.io
- Installing docker compose
  - mkdir -p ~/.docker/cli-plugins/
  - wget -O ~/.docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.32.1/docker-compose-linux-x86_64
  - chmod +x ~/.docker/cli-plugins/docker-compose
### Step 3: Giving a user permission to run the docker container
- sudo usermod -aG docker $user
- newgrp docker
### Step 4: Create Directories for the Graylog Docker Container
- sudo mkdir /docker && cd /docker
- git clone https://github.com/lawrencesystems/graylog.git
### Step 5: Changing the Default Password (Recommended)
- Default credentials admin. Admin
- To change password
  - echo -n yourpassword | shasum -a 256
  - Update this line in the docker-compose.yml
    - cd graylog
    - vim docker-compose.yml
    - Find this line and update it: GRAYLOG_ROOT_PASSWORD_SHA2:
### Step 6: Starting Graylog
- docker compose up -d
### Step 7: Getting Into Graylog
- Go to http://GRAYLOG_SERVER_IP:9000
- Login with your credentials (username = admin)
### Step 8: Setting up the Input 
- Go to System (Top right) -> Inputs
- Set input to Syslog TCP and launch the new input. 
- Title: Syslog input
- Port: 1514
- Keep everything else the same
### Step 9: Setting up the Clients to Send to Graylog
- sudo nano /etc/rsyslog.conf
- *.* @<graylog_ip>:<graylog_udp_port>
- sudo systemctl restart rsyslog

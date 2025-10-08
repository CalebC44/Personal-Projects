# Start from an official Ubuntu or Debian base
FROM ubuntu:24.04

# Suppress some interactive prompts in Docker build
ENV DEBIAN_FRONTEND=noninteractive

# Step 0: Update/Upgrade system and install required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/apache2 && \
    apt-get update && \
    apt-get install -y \
        apache2 \
        apache2-utils \
        git \
        libapache2-mod-security2 \
        vim \
        openssl

#Coping over config files
COPY setup/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY setup/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
COPY setup/security2.conf /etc/apache2/mods-available/security2.conf

#Creating SSL Certificate
RUN openssl req -x509 -nodes -days 90 -newkey rsa:2048 \
    -keyout /etc/ssl/private/apache-selfsigned.key \
    -out /etc/ssl/certs/apache-selfsigned.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=example.com"

# Setting up ModSecurity
RUN mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
RUN sed -i 's/^SecRuleEngine DetectionOnly/SecRuleEngine On/' /etc/modsecurity/modsecurity.conf
COPY setup/coreruleset-4.9.0/rules /etc/modsecurity/rules
COPY setup/coreruleset-4.9.0/crs-setup.conf.example /etc/modsecurity/crs/crs-setup.conf

# Adjusting permissions
RUN chown -R www-data:www-data /var/www/html
RUN find /var/www/html -type d -exec chmod 750 {} \; && \
    find /var/www/html -type f -exec chmod 640 {} \;

# Enable required Apache modules
RUN a2enmod ssl headers security2 rewrite && \ 
    a2ensite default-ssl.conf

# Hide Apache version info
RUN sed -i 's/^ServerTokens OS/ServerTokens ProductOnly/' /etc/apache2/conf-available/security.conf && \
    sed -i 's/^ServerSignature On/ServerSignature Off/' /etc/apache2/conf-available/security.conf

# Expose ports 80 (HTTP) and 443 (HTTPS)
EXPOSE 80 443
# Finally set the command to run Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]

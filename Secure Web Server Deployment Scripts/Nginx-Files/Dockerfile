# Use the official Ubuntu 22.04 LTS as the base image
FROM ubuntu:24.04

# Set environment variable to non-interactive to suppress prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Step 0: Update and upgrade the system
RUN apt-get update && apt-get upgrade -y
# Step 1: Install required libraries and dependencies
RUN apt-get install -y software-properties-common \
    && apt-get install -y \
        apt-utils \
        software-properties-common \
        gnupg2 \
    && add-apt-repository ppa:ondrej/nginx -y \
    && apt-get update -y \
    && apt-get install -y \
        nginx \
        gcc \
        make \
        build-essential \
        autoconf \
        automake \
        libtool \
        libcurl4-openssl-dev \
        liblua5.3-dev \
        libfuzzy-dev \
        ssdeep \
        gettext \
        pkg-config \
        libgeoip-dev \
        libyajl-dev \
        doxygen \
        libpcre3-dev \
        libpcre2-16-0 \
        libpcre2-dev \
        libpcre2-posix3 \
        zlib1g \
        zlib1g-dev \
        git \
        vim \
        wget \
        libssl-dev \
        libxml2 \
        libxml2-dev

# Step 2: Configure SSL with a self-signed certificate
RUN mkdir -p /etc/ssl/private /etc/ssl/certs \
    && openssl req -x509 -nodes -days 6 -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out /etc/ssl/certs/nginx-selfsigned.crt \
        -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"

# Step 3: Install ModSecurity
RUN git clone https://github.com/SpiderLabs/ModSecurity.git /opt/ModSecurity\
    && cd /opt/ModSecurity \
    && git submodule init \
    && git submodule update \
    && ./build.sh \
    && ./configure \
    && make \
    && make install

# Step 4: Download ModSecurity-nginx Connector
RUN git clone https://github.com/SpiderLabs/ModSecurity-nginx.git /opt/ModSecurity-nginx

# Step 5: Download nginx source code and compile with ModSecurity module
RUN wget https://nginx.org/download/nginx-1.26.2.tar.gz -P /opt \
    && tar -xzvf /opt/nginx-1.26.2.tar.gz -C /opt \
    && cd /opt/nginx-1.26.2 \
    && ./configure --with-compat --add-dynamic-module=/opt/ModSecurity-nginx\
    && make && make modules \
    && cp objs/ngx_http_modsecurity_module.so /etc/nginx/modules-enabled/ \
    && cp /opt/ModSecurity/modsecurity.conf-recommended /etc/nginx/modsecurity.conf \
    && cp /opt/ModSecurity/unicode.mapping /etc/nginx/unicode.mapping

# Step 6: Enable ModSecurity in nginx.conf
COPY setup/nginx.conf /etc/nginx/nginx.conf

# Step 7: Change default site configuration and restart nginx
COPY setup/default /etc/nginx/sites-available/default

# Step 8: Update Rule with OWASP Core Rule Set
RUN git clone https://github.com/coreruleset/coreruleset.git /etc/nginx/owasp-crs \
    && cp /etc/nginx/owasp-crs/crs-setup.conf.example /etc/nginx/owasp-crs/crs-setup.conf \
    && sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/' /etc/nginx/modsecurity.conf \
    && echo "Include /etc/nginx/owasp-crs/crs-setup.conf" >> /etc/nginx/modsecurity.conf \
    && echo "Include /etc/nginx/owasp-crs/rules/*.conf" >> /etc/nginx/modsecurity.conf 

# Expose HTTP and HTTPS ports
EXPOSE 80 443

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]


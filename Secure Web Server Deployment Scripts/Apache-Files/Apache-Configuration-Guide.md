[Offical Documentation](https://httpd.apache.org/docs/2.4/)
Note: When changing ports make sure to do it in ports.conf as well.
Configuration Rules
- VirtualHost PORT:PORT : sets the the configurations for that port
- ServerAdmin : This will be shown on error messages given by the server
- ServerName : set the servers name for DNS can list multiple
- ServerAlias : can be linked to the server name
- DocumentRoot /var/www/html : Sets the default root directory for html files
### Logging
- ErrorLog /var/log/apache2 : Error log location
-  CustomLog /var/log/apache2: Used for access.log
### SSL
- SSLEngine on : used for HTTPS
- SSLCertificateFile /etc/ssl/certs/*.crt: cert file
- SSLCertificateKeyFile /etc/ssl/private/*.key : key file
- SSLCipherSuite EECDH+AESGCM:EDH+AESGCM : Use strong ciphers only
- SSLHonorCipherOrder On : Used to enforce server-side cipher preference
- SSLProtocol -all +TLSv1.3 +TLSv1.2 : Only use the strong SSL protocols
- SSLOpenSSLConfCmd Curves X25519:secp521r1:secp384r1:prime256v1 : elliptic curve
- SSLCompression off : Prevents CRIME attacks
- Security Headers 
- Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" : Only use HTTPS Requires (mod_headers.c)
- Header always set X-Frame-Options DENY : Prevent the page from being displayed on an Iframe. Requires (mod_headers.c)
- Header always set X-Content-Type-Options nosniff : Stops MIME sniffing
- SSLSessionTickets Off : NOT SURE
- Redirect "/" "https://localhost/" : Used to redirect one to another
- Disable Server tokens
### Security.conf
- ServerTokens On >> ServerTokens ProductOnly
- ServerSignature On >> ServerSignature Off

### More Complex Configuration Rules
- Access control : https://httpd.apache.org/docs/2.4/howto/access.html
### Directory Rules
- Require all granted OR None: Allows access to the directory for all clients or no clients
- Options FollowSymLinks: Permits Apache to follow symbolic links within the directory.
- AllowOverride None: Disables the use of .htaccess files to override server configuration in this directory.
- DirectoryIndex index.html: Specifies that index.html should be served as the default file when a directory is requested.
- Require ip 1.2.3.4 OR 192.168.0.0/24 : Only this Ip can access the website

Apache commands:
- Testing site configs 
  - apachectl configtest
- Enabling mods and site configs
  - a2enmod ssl
  - a2ensite default-ssl.conf
- Disabling mods and site configs
  - a2dismod ssl
  - a2dissite default-ssl.conf
- View Active Connections to Apache:
  - netstat -plnt | grep apache2
- Check Apache Version:
  - apache2 -v
- Check Installed Modules:
  - apache2ctl -M
- Restart Apache Gracefully (No Connection Drops):
  - apachectl graceful
- Tail Error Logs in Real-Time
  - tail -f /var/log/apache2/error.log



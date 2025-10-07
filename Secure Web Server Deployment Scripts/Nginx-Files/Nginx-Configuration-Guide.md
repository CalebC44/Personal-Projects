## Documentation:
- https://nginx.org/en/docs/
- https://nginx.org/en/docs/dirindex.html
- https://docs.nginx.com/nginx/admin-guide/web-server/

## Main Context
- user www-data : specifies which system user or group the nginx worker process will run as
- worker_processses auto : sets the number of worker process
- Include : used to include other config files
## Events
- worker_connections : Defines the maximum number of simultaneous connects that can be opened by a worker process
## HTTP Context
- Include : used to include other files
## Server Context - Basic
- Listen 80 default_server; - listen on port 80, the default_server sets the default for requests on this port if no other server block matches the incoming request.
- listen [::]:80 default_server; - Instructs Nginx to listen on port 80 for IPv6 addresses.
- server name : species one or more domain names that this server block should respond to
- error_page - used to set custom error pages
- return 301 - returns a specified http code (this does http to https) (301 moved permanently)
- rewrite - rewrite the urls based on a regular expression
- proxy_pass - forwards request to another server
- try_files - checks if files exist and servers them or falls back to another location if not found.
- server_tokens off; - turn of the banner
  
## Root and Index
- root /var/www/html; - set root directory
- index index.html - set default html file shown
## Logging (server{})
- access_log /var/log/nginx/access.log; - access log location
- error_log /var/log/nginx/error.log warn; - error log location
- log_format main : used to define a custom logs
## SSL 
- Listen 443 ssl; - tell nginx to listen on 443 https
- ssl_certificate /etc/ssl/certs/*.crt;
- ssl_certificate_key /etc/ssl/private/*.key;
- ssl_protocols TLSv1.2 TLSv1.3; - Only use strong ssl protocols
- ssl_prefer_server_ciphers on; - cipher control
## Security Headers
- add_header Strict-Transport-Security "max-age=31536000;includeSubDomains; preload" always; - only use HTTPS
- add_header X-Frame-Options "SAMEORIGIN" always; - prevent clickjacking
- add_header X-Content-Type-Options "nosniff" always; - prevent MIME sniffing
- add_header X-XSS-Protection "1; mode=block" always; - XSS protection
- add_header Content-Security-Policy "default-src 'self'; script-src 'self'; object-src 'none'; base-uri 'self';" always; - No idea
- add_header Referrer-Policy "strict-origin-when-cross-origin" always; - referrer policy?
## Location Context - location <location> {}
- Add_header
- allow 192.168.1.100; - allow connection coming from this ip
- deny all; - deny all connections 

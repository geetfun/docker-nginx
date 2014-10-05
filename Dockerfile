# Pull base image.
FROM dockerfile/ubuntu
MAINTAINER Simon Chiu

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
    echo "include /etc/nginx/sites-enabled/*;" >> /etc/nginx/conf.d/nginx-sites.conf

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/usr/share/nginx/html"]

# Define working directory.
WORKDIR /etc/nginx

# Expose ports.
EXPOSE 80
EXPOSE 443

# Define default command.
CMD ["nginx"]
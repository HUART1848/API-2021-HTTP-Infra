FROM nginx

# Config file
COPY ./default.conf /etc/nginx/conf.d/default.conf

# 404 Error page
COPY ./404.html /var/www/html/404.html

# Reverse-proxy includes
COPY ./includes/ /etc/nginx/includes/

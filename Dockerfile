FROM nginx

ENV TERM xterm

# install essential Linux packages
RUN apt-get update -qq && apt-get -y install apache2-utils curl

# where we store everything SSL-related
ENV SSL_ROOT /var/www/ssl
 
# where Nginx looks for SSL files
ENV SSL_CERT_HOME $SSL_ROOT/certs/live
 
# copy over the script that is run by the container
COPY nginx_cmd.sh /tmp/

# copy configuration file
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

CMD [ "/tmp/nginx_cmd.sh" ]

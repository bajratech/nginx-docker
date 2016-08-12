FROM nginx

ENV TERM xterm

# install essential Linux packages
RUN apt-get update -qq && apt-get -y install apache2-utils curl

# where we store everything SSL-related
ENV SSL_ROOT /home/keys/letsencrypt
 
# where Nginx looks for SSL files
ENV SSL_CERT_HOME $SSL_ROOT/certs/live

ENV CA_SSL true

#copy letsencrypt
COPY letsencrypt.sh /home/keys/letsencrypt/
RUN chmod +x /home/keys/letsencrypt/letsencrypt.sh

# generate a strong Diffie-Hellman group
# RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
 
# copy over the script that is run by the container
COPY nginx_cmd.sh /tmp/
RUN chmod +x /tmp/nginx_cmd.sh

# copy configuration file
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

CMD [ "/tmp/nginx_cmd.sh" ]

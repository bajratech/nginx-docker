FROM nginx

ENV TERM xterm

# install certbot
RUN apt-get update && apt-get install -qy nano wget
RUN cd /root/ && wget https://dl.eff.org/certbot-auto
RUN chmod a+x /root/certbot-auto
RUN /root/certbot-auto <<< $'yes'

# generate a strong Diffie-Hellman group
RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# copy configuration file
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
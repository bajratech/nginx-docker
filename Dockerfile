FROM debian

ENV TERM xterm

# install certbot and cron
RUN apt-get update && apt-get install -qy nano wget cron nginx
RUN cd /root/ && wget https://dl.eff.org/certbot-auto
RUN chmod a+x /root/certbot-auto
RUN yes | /root/certbot-auto; exit 0

# generate a strong Diffie-Hellman group
RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

#add renew script
COPY renew.sh /root/renew.sh
RUN chmod +x /root/renew.sh

#add renew job that runs every day
RUN echo "@midnight /root/renew.sh >> /home/keys/renewSh.txt" 

# copy configuration file
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
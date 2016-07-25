FROM nginx:1.10.1

#install certbot
RUN cd /root/ && wget https://dl.eff.org/certbot-auto
RUN chmod a+x /root/certbot-auto

# copy configuration file
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf


#!/bin/bash

/root/certbot-auto renew > /home/keys/renew.txt
count=`cat /home/keys/renew.txt | grep -c "No renewals were attempted"`
if [ $count -ne 0 ]; then
     echo "No renewals were attempted." && exit 0
else
	cp /etc/letsencrypt/live/beta.sitegranny.com/cert.pem /home/keys/beta.sitegranny.com/
	cp /etc/letsencrypt/live/beta.sitegranny.com/chain.pem /home/keys/beta.sitegranny.com/
	cp /etc/letsencrypt/live/beta.sitegranny.com/privkey.pem /home/keys/beta.sitegranny.com/
	cp /etc/letsencrypt/live/beta.sitegranny.com/fullchain.pem /home/keys/beta.sitegranny.com/
    service nginx reload
fi
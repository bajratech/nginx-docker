#!/bin/bash
> /home/keys/renew.txt
date >> /home/keys/renew.txt
/root/certbot-auto renew >> /home/keys/renew.txt
count=`cat /home/keys/renew.txt | grep -c "No renewals were attempted"`
if [ $count -ne 0 ]; then
     echo "No renewals were attempted." && exit 0
else
	cp /etc/letsencrypt/live/sitegranny.com/cert.pem /home/keys/sitegranny.com/
	cp /etc/letsencrypt/live/sitegranny.com/chain.pem /home/keys/sitegranny.com/
	cp /etc/letsencrypt/live/sitegranny.com/privkey.pem /home/keys/sitegranny.com/
	cp /etc/letsencrypt/live/sitegranny.com/fullchain.pem /home/keys/sitegranny.com/
    service nginx reload
fi
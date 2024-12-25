sudo docker run -it --rm --name certbot \
    -v "./cloudflare.ini:/root/.secrets/cloudflare.ini"\
    -v "./ssl/:/etc/letsencrypt/" \
    -v "./log/:/var/log/letsencrypt/" \
    certbot/dns-cloudflare certonly \
        --preferred-challenges dns-01 \
        --agree-tos --key-type rsa \
        --dns-cloudflare \
        --dns-cloudflare-credentials /root/.secrets/cloudflare.ini \
        --dns-cloudflare-propagation-seconds 30 \
        -d newthread.run,*.newthread.run,*.kr.newthread.run,*.ca.newthread.run \
        -n -m "andyfan.vip@gmail.com"
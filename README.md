# POT Vector Tiles

Skrypty służące do generowania i serwowania kafelków wektorowych. Styl jest utworzony na podstawie [osm-bright-gl](https://github.com/openmaptiles/osm-bright-gl-style). Styl można edytować przy pomocy aplikacji [maputnik](https://maputnik.github.io/).

## Wymagania systemowe

* System operacyjny UBUNTU 20 LTS albo wyższa (wyłącznie wersja LTS)

## Instalacja i początkowa konfiguracja

Do geneorwania i serwowania wymagany jest `Docker` z uprawnieniami sudo oraz `Nginx`:

```bash
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
```

```bash
sudo apt install nginx
```

Zaleca się odpowiednio skonfigurować firewall.

```bash
sudo apt install ufw
sudo ufw allow 'Nginx Full'
sudo ufw enable

# check firewall status
sudo ufw status
```

Instalacja i konfiguracja SSL

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d DOMENA

# auto renewal
sudo systemctl status certbot.timer

# testing renewal process
sudo certbot renew --dry-run
```

Konfiguracja Nginx

```bash
sudo vim /etc/nginx/sites-enabled/default
```

```
location ~*  \.(jpg|jpeg|png|webp)$ {
  proxy_set_header X-Real-IP         $remote_addr;
  proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Proto $scheme;
  proxy_set_header X-Forwarded-Host  $host;
  proxy_set_header X-Forwarded-Port  $server_port;
  proxy_set_header Host              $host;

  # 604800=7 days
  add_header Cache-Control "public, max-age=604800";

  proxy_pass http://127.0.0.1:8080;
}

location / {
  proxy_set_header X-Real-IP         $remote_addr;
  proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Proto $scheme;
  proxy_set_header X-Forwarded-Host  $host;
  proxy_set_header X-Forwarded-Port  $server_port;
  proxy_set_header Host              $host;

  proxy_pass http://127.0.0.1:8080;
}
```

restart nginx after saving below config

```bash
sudo systemctl restart nginx
```

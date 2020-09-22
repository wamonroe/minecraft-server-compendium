# Minecraft Server Compendium

Simple compendium application for sharing details about hosted Minecraft servers. It was created
primarily around sharing points-of-interest (coordinates) with friends and family that play together
on the same Minecraft server(s).

Built with Rails, Stimulus JS, and Tailwind CSS.

## Deploy

*Basic instructions mostly to remind myself.*

I'd like to expand up the Capistrano setup at some point, but right now following steps assume
the following:

* You can ssh into the server using an SSH key (not password)
* The server is running a Ubuntu 20.04 and you have done some initial server setup such as
creating a user account, see DigitalOcean's guide [Initial Server Setup](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-20-04).
* Ruby is installed with rbenv, see DigitalOcean's guide [How to Install Ruby on Rails with rbnevn](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-18-04).
Note, you don't need to install Rails, but rbenv and a version of Ruby would be good.
* The [rbenv-vars](https://github.com/rbenv/rbenv-vars) extension should be installed.
* Node.js and Yarn should be installed, see Linuxize's guide [How to Install Yarn](https://linuxize.com/post/how-to-install-yarn-on-ubuntu-20-04/).
* PostgreSQL should be installed, see DigitalOcean's guide [How to Install and Use PostgreSQL](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-20-04).

### Define Application Settings

On the server, create a file named `~/.rbenv-vars`.

Inside define a number of environmental variables to configure MSC.

```bash
# MSC Application Settings
SECRET_KEY_BASE=<value>
RAILS_ENV=production

# MSC Database Settings
MSC_DB_HOST=127.0.0.1
MSC_DB_USER=msc
MSC_DB_PASS=<value>

# MSC Mail Settings
MSC_SMTP_HOST=<value>
MSC_SMTP_PORT=<value>
MSC_SMTP_USER=<value>
MSC_SMTP_PASS=<value>
MSC_SMTP_TLS=true

# MSC Host Settings
MSC_HOST=https://<value>
MSC_PORT=443
```

Symlink this file to `/srv/msc/shared/.rbenv-vars`, change `USER` below to equal the user account
created.

```bash
sudo mkdir -p /srv/msc/shared
chown -R USER:USER /srv/msc
ln -s ~/.rbenv-vars /srv/msc/shared
```

### Setup Puma

> TODO: This can be automated through Capistrano, but I haven't gotten there yet.

On the server, create a file named `/etc/systemd/system/puma-msc.service`

```conf
[Unit]
Description=MSC Puma Server
After=network.target

[Service]
Type=simple
User=rails
EnvironmentFile=/srv/msc/current/.rbenv-vars
Environment=RAILS_ENV=production
WorkingDirectory=/srv/msc/current
ExecStart=/home/rails/.rbenv/bin/rbenv exec bundle exec puma -C /srv/msc/current/config/puma.rb
ExecStop=/home/rails/.rbenv/bin/rbenv exec bundle exec pumactl -F /srv/msc/current/config/puma.rb stop
ExecReload=/home/rails/.rbenv/bin/rbenv exec bundle exec pumactl -F /srv/msc/current/config/puma.rb phased-restart
TimeoutSec=15
Restart=always
KillMode=process

[Install]
WantedBy=multi-user.target
```

### Install and Setup Nginx

> TODO: Some of this can be automated through Capistrano, but I haven't gotten there yet.

Install Nginx using apt

```bash
sudo apt install nginx
```

Disable the default site by removing the symlink

```bash
sudo rm /etc/nginx/sites-enabled/default
```

Create a new site (replace site name below to match)

```bash
sudo vi /etc/nginx/sites-available/myserver.com
```

Paste in the follow contents and modify as necessary:

```text
upstream msc_app {
    server unix:/srv/msc/shared/tmp/sockets/puma.sock fail_timeout=0;
}

server {
    listen 80;
    root /srv/msc/current/public;
    index index.html index.htm;
    if ($http_transfer_encoding ~* chunked) {
        return 444;
    }

    server_name myserver.com;

    access_log off;

    location ~ ^/assets/ {
      gzip_static on;
      expires max;
      add_header Cache-Control public;
    }

    location / {
      try_files $uri.html $uri @app;
    }

    location @app {
      include proxy_params;
      proxy_redirect off;

      proxy_pass http://msc_app;
    }
}
```

Enable the site

```bash
sudo ln -s /etc/nginx/sites-available/myserver.com /etc/nginx/sites-enabled/
```

Enable and start nginx

```bash
sudo systemctl enable nginx
sudo systemctl start nginx
```

### Secure Nginx with Let's Encrypt

See DigitalOcean's guide [How to Secure Nginx with Let's Encrypt](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-20-04).

### Run the Deploy

On your local computer, in this directory where you cloned this repository, create a file named
`config/deploy.yml`

Inside define the the Capistrano stages (production, staging) as top level keys, followed by
`server`, the hostname of the server, and the Capistrano server options, for example:

```yaml
production:
  servers:
    'prodsrv.example.com':
      user: 'deploy'
      roles:
        - app
        - web
        - db
staging:
  servers:
    'stagingsrv.example.com':
      user: 'deploy'
      roles:
        - app
        - web
        - db
```

Run `bundle exec cap staging deploy` or `bundle exec cap production deploy`

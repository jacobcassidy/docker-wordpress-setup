# Docker WordPress Setup

This repository contains the files needed to quickly get up and running with a local WordPress development Docker container. The container uses the official Docker __wordpress image__ for the server, __MySQL__ for the database, __local volumes__ for live editing of the files and database, and installs __Composer__ remotely at `/usr/local/share/composer` for running global packages in your Docker container.

Included below are one-time setup instructions for creating a __standalone NGINX Reverse Proxy Docker network__. The network container will allow you to run multiple local servers simultaneously, all using unique local domain names on the standard 80 (HTTP) or 443 (HTTPS) ports. This removes the need to manage port numbers, gives you clean domains to work from (no appended port number), and manages running your local domains on the HTTPS protocol with self-created SSL certificates.

## Other Docker Container Setup Repositories

Depending on what stack you're using and whether you use [Ray](https://myray.app/) for debugging, another setup may be a better fit:

| Setups without the Global Ray package| Setups with the Global Ray package |
| - | - |
| [NGINX, PHP-FPM & MySQL](https://github.com/jacobcassidy/docker-nginx-phpfpm-setup) | [NGINX, PHP-FPM, MySQL, & Ray](https://github.com/jacobcassidy/docker-nginx-phpfpm-ray-setup) |
| [WordPress & MySQL](https://github.com/jacobcassidy/docker-wordpress-setup) | [WordPress, MySQL, & Ray](https://github.com/jacobcassidy/docker-wordpress-ray-setup) |

## Instructions

### First Time Setup

For all features to work, you must do a one-time setup of the following:

1. Install the following command line tools on your local machine:
    - [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
    - [mkcert](https://github.com/FiloSottile/mkcert)
2. Install the [Docker Desktop](https://www.docker.com/products/docker-desktop/) app.
3. Build the Docker standalone Reverse Proxy network container:
    - Open the Docker Desktop app so the Docker engine is on.
    - In the parent directory where you want to store your network image files, such as _/users/username/projects/assets/docker/_, run: `git clone git@github.com:jacobcassidy/docker-localhost-network.git`.
    - In the _docker-localhost-network_ directory you just cloned, run: `docker compose up -d` to build and start the Docker network container. That's it, your network is now running.

### Continued/Additional Setup

1. In the parent directory where you want your project directory nested, run `git clone git@github.com:jacobcassidy/docker-wordpress-setup.git`.
2. Rename the cloned directory from `docker-wordpress-setup` to your project name.
3. Rename the `.env-example` file to `.env`.
4. Update the `.env` file with the values your project will use.
5. In the `docker-localhost-network/certs` directory you created in the __First Time Setup__ instructions above, create the SSL certificates needed for the HTTPS protocol using the command: `mkcert yourdomain.localhost`. Make sure you replace "yourdomain.localhost" with the local domain name you specified in your `.env` file.
6. Rename the created SSL certificates:
    | FROM | TO |
    | - | - |
    | yourdomain.localhost-key.pem | yourdomain.localhost.key |
    | yourdomain.localhost.pem | yourdomain.localhost.crt |
7. Open the [Docker Desktop](https://www.docker.com/products/docker-desktop/) app so the Docker engine is on.
8. In your project directory, run `docker compose up -d` to build the   WordPress server Docker container. This will start your server and add the following directories to your project directory:
    - `/html`: contains the WordPress files.
    - `/log`: will contain the `wp-errors.log` file when WordPress has an error (the directory will be empty until there's an error).
    - `/storage/mysql`: contains the database.
9. Replace this README content with your project's README content (you can view the original README [here](https://github.com/jacobcassidy/docker-wordpress-setup)).
10. Remove the cloned _docker-wordpress-setup_ __.git__ directory with: `rm -rf .git` (run this command from your project directory).
11. Initialize a new git repository for your project with: `git init`.
12. If you will be using a GitHub remote repo, create and connect to it now.
13. Open your browser to the local domain specified in your `.env` file and complete the WordPress installation.

## Issues?

If you come across any issues, please feel free to report them [here](https://github.com/jacobcassidy/docker-wordpress-setup/issues).

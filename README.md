# Docker WordPress Setup

This repository contains the files needed to quickly get up and running with a local WordPress development Docker container. The container uses the official Docker __wordpress image__ for the server, __MySQL__ for the database, __local volumes__ for live editing of the files and database, and installs __Composer__ remotely at `/usr/local/share/composer` for running global packages in your Docker container.

Included below are one-time setup instructions for creating a __stand-alone NGINX Reverse Proxy Docker network__. This network container will allow you to run multiple containers simultaneously, all using unique local domain names on the standard 80 (HTTP) or 443 (HTTPS) ports.

This removes the need to manage port numbers, gives you clean domains to work from (no appended port number), and manages running your local domains on the HTTPS protocol.

## Other Docker Container Setup Repositories

Depending on what stack you're using and whether you use the [Ray app](https://myray.app/) for debugging, another setup may be a better fit:

| Setups without the Global Ray package| Setups with the Global Ray package |
| - | - |
| [NGINX, PHP-FPM & MySQL](https://github.com/jacobcassidy/docker-nginx-phpfpm-setup) | [NGINX, PHP-FPM, MySQL, & Ray](https://github.com/jacobcassidy/docker-nginx-phpfpm-ray-setup) |
| [WordPress & MySQL](https://github.com/jacobcassidy/docker-wordpress-setup) | [WordPress, MySQL, & Ray](https://github.com/jacobcassidy/docker-wordpress-ray-setup) |

## Instructions

### First Time Setup

For all features to work, you must do a one-time setup of the following:

1. Make sure the following command line tools are installed on your local machine:
    - [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
    - [mkcert](https://github.com/FiloSottile/mkcert)
2. Create a stand-alone reverse proxy network (to use multiple local domains on the standard 80 or 443 ports):
    - In the parent directory where you want to store your network files (such as `/Users/Username/Projects/Assets/Docker/`), run: `git clone git@github.com:jacobcassidy/docker-localhost-network.git`.
    - From the `docker-localhost-network` directory you just cloned, run: `docker compose up -d` to build and start the container.

### Continued/Additional Setup

1. Run `git clone git@github.com:jacobcassidy/docker-wordpress-setup.git` in the parent directory where you want your project directory nested.
2. Rename the cloned directory from "docker-wordpress-ray-setup" to your project name.
3. Rename the `.env-example` file to `.env`.
4. Update the `.env` file with the values your project will use.
5. In the `/docker-localhost-network/certs` directory you created in the __First Time Setup__ instructions above, create the SSL certs needed for the HTTPS protocol using the command: `mkcert yourdomain.localhost`. Make sure you replace "yourdomain.localhost" with the local domain name you specified in your `.env` file.
6. Rename the created certs from `yourdomain.localhost-key.pem` to `yourdomain.localhost.key` and `yourdomain.localhost.pem` to `yourdomain.localhost.crt`
7. Open the [Docker Desktop](https://www.docker.com/products/docker-desktop/) app so the Docker engine is on.
8. Build the Docker container with: `docker compose up -d` (run this command in the project directory). This will create your server and add the following directories to your project directory:
    - `/html`: contains the WordPress files.
    - `/log`: will contain the `wp-errors.log` file when WordPress has an error (the directory will be empty until there's an error).
    - `/storage/mysql`: contains the database.
9. Replace this README content with your project's README content (you can view the original README [here](https://github.com/jacobcassidy/docker-wordpress-setup)).
10. Remove the cloned docker-wordpress-ray-setup's `.git` directory with: `rm -rf .git` (run this in your project directory).
11. Initialize a new git repository for your project with: `git init`.
12. If you will be using a GitHub remote repo, create and connect to it now.
13. Open your browser to the local domain specified in your `.env` file and complete the WordPress installation.

## Issues?

If you come across any issues, please feel free to report them [here](https://github.com/jacobcassidy/docker-wordpress-setup/issues).

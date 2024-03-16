# WP Starter Docker

The repo contains the files needed to quickly get up and running with a WordPress local development Docker container. The container uses local volumes for the files and database, nginx-proxy to configure the local HTTPS protocol, and composer to add a connection to the Ray desktop app (a debugging tool).

## Usage

### First Time Setup

For all features to work, you must do a one-time setup of the following:

1. Make sure the following command line tools are installed:
    - [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
    - [Composer](https://getcomposer.org/download/) (if you don't use the [Ray](https://spatie.be/products/ray) app, you can skip this one.)
    - [mkcert](https://github.com/FiloSottile/mkcert)
2. For the local Ray desktop app to communicate with the Docker server, you must add `127.0.0.1 host.docker.internal` to your local `/etc/hosts` file.
3. Create a stand-alone project directory to contain a nginx-proxy Docker container, such as `/Users/Jacob/Projects/Assets/Docker/localhost-network`.
    - Add a `compose.yaml` file and `/cert` directory (which will be used later) in the `localhost-network` directory.
    - Add the following to the `compose.yaml` file and save it:
    ```yaml
    services:
      nginx-proxy:
        image: nginxproxy/nginx-proxy:latest
        ports:
          - "80:80"
          - "443:443"
        volumes:
          - ./certs:/etc/nginx/certs
          - /var/run/docker.sock:/tmp/docker.sock:ro

    networks:
      default:
        name: localhost-network
      ```
      - Run `docker compose up -d --build` to create the container.

### Continued/Additional Setup

The following are run in the command line within your local project directory unless otherwise noted:

1. Run `git clone git@github.com:jacobcassidy/wp-starter-docker.git` in the parent directory where you want your project directory nested.
2. Rename the cloned directory from "wp-starter-docker" to your project name.
3. Rename the `.env-example` file to `.env`.
4. Update the `.env` file with the usernames, passwords, unique port number (allows connecting with multiple DB containers), local file path, and local domain your project will use.
5. If using the Ray app, run: `composer install` to install the composer Ray package and dependencies. This will create the `/vendor` directory and `composer.lock` file within your project directory.
6. In the `/localhost-network/certs` directory you created in the __First Time Setup__ instructions above, create the SSL certs for the HTTPS protocol using the command: `mkcert yourlocaldomain.tld`. Make sure you replace "yourlocaldomain.tld" with the local domain name you specified in your `.env` file.
7. Rename the created certs from `yourlocaldomain.tld-key.pem` to `yourlocaldomain.tld.key` and `yourlocaldomain.tld.pem` to `yourlocaldomain.tld.crt`
8. Open the [Docker Desktop](https://www.docker.com/products/docker-desktop/) app so the Docker engine is on.
9. Build the docker container with: `docker compose up -d --build`. This will create your server and add the following directories to your project directory:
    - `/html`: contains the WordPress files.
    - `/log`: will contain the `wp-errors.log` file when WordPress has an error (the directory will be empty until there's an error).
    - `/storage/mysql`: contains the database.
8. Open your browser to the local domain specified in your `.env` file and complete the WordPress installation.

> Note: The main volumes path for the wordpress image in `compose.yaml` must be linked to `/var/www/html` for the wordpress image to work.

## If using the Ray app for debugging

To use the `ray()` function in a PHP file, you will need to include the Ray class file. The easiest way to do that is to include `require_once ABSPATH . '/../vendor/autoload.php';` in each PHP file you are calling the `ray()` function in.

## If NOT using the Ray app for debugging

You can use the setup as is and everything will still work as intended. However, if you'd like to remove unneeded files and settings that are only for Ray, these are the steps:

1. Delete the `ray.php` and `composer.json` files.
2. Skip running the `composer install` step in the usage instructions above.
2. Remove the `FULL_LOCAL_PATH` line from the `.env` file.
3. In the `compose.yaml` file, remove the following lines:
    - `FULL_LOCAL_PATH: ${FULL_LOCAL_PATH} # For use in ray.php`
    - `- ./vendor:/var/www/vendor`
    - `- ./composer.json:/var/www/composer.json`
    - `- ./composer.lock:/var/www/composer.lock`
    - `- ./ray.php:/var/www/ray.php`

## What is the Ray app?

[Ray](https://spatie.be/products/ray) is a commercial app created by Spatie. It allows quick debugging using the `ray()` function. You can think of it as the middle ground between using functions such as `var_dump()` and using Xdebug (for when you don't need the full power of Xdebug).

Unlike with `var_dump()`, `print_r()`, and other similar built-in functions, `ray()` doesn't output the data directly to the webpage. Instead, it's outputted in the Ray desktop app, which allows you to keep your web pages clean and see the debugging data output in a nice format in its own window.

## Why use wp-starter-docker instead of directly using the wordpress image?

Using the wordpress image directly will create a self-contained container. This means your local data would not be connected, and you would need to connect to the Docker container to do your development. It would also use the non-secure HTTP protocol, which can cause issues using third-party APIs and other tools.

The `wp-starter-docker` setup adds local volumes so you can do all your development locally and have it reflected in the Docker container. This allows you to create or destroy the Docker container without deleting your site files or database since they are stored on your local machine.

## Issues?

If you come across any issues, please feel free to report them [here](https://github.com/jacobcassidy/wp-starter-docker/issues).

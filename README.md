# WP Starter Docker

The repo contains the files needed to quickly get up and running with a WordPress local development docker container. The container uses local volumes for the files and database. It also provides the configuration to connect docker to your local Ray desktop app for quick debugging.

## Usage

The following are run in the command line within your project directory, unless otherwise noted:

1. Run the following git clone command one directory up from where you want your project directory: `git clone git@github.com:jacobcassidy/wp-starter-docker.git`.
2. Rename the cloned directory from "wp-starter-docker" to your project name.
3. Update the `.env` file with the usernames, passwords, and local path your project will use.
4. Run: `composer install` to install the composer Ray package and dependencies. This will create the `/vendor` directory and `composer.lock` file within your project directory. Note: if you don't have [Composer](https://getcomposer.org/download/) installed, you must install it first before this command will work.
4. Open the [Docker Desktop](https://www.docker.com/products/docker-desktop/) app so the Docker engine is on.
5. Build the docker container with: `docker compose up -d --build`. This will create your server and add the following directories to your project directory:
    - `/html`: contains the WordPress files.
    - `/log`: will contain the `wp-errors.log` file created when WordPress has an error.
    - `/storage/mysql`: contains the database.
6. Open your browser to http://localhost:8000/ and complete the WordPress installation.

> Note: The main volumes path for the wordpress image in `compose.yaml` must be linked to `/var/www/html` for the wordpress image to work.

## If using the Ray app for debugging

For the local Ray desktop app to communicate with the Docker server, you must add `127.0.0.1 host.docker.internal` to your local `/etc/hosts` file. This only needs to be done once, so if you have previously done this step, you don't need to do it again.

To use the `ray()` function in a PHP file, you will need to include the Ray class file. The easiest way to do that is to include `require_once ABSPATH . '/../vendor/autoload.php';` in the PHP file you are calling the `ray()` function in.

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

Unlike with `var_dump()`, `print_r()`, and other similar built-in functions, `ray()` doesn't output the data directly to the webpage. Instead, it's outputted in the Ray desktop app. Which allows you to keep your webpages clean and see the debugging data output in its own window in a nice clean format.

## Why use wp-starter-docker instead of directly using the wordpress image?

Using the wordpress image directly will create a self-contained container. This means your local data would not be connected and you would need to connect to the Docker container to do your development.

The `wp-starter-docker` setup adds local volumes so you can do all your development locally and have it reflected in the Docker container. This setup also allows you to create or destroy the Docker container without it deleting your site files or database since they are stored on your local machine.

## Issues?

If you come across any issues, please feel free to report them [here](https://github.com/jacobcassidy/wp-starter-docker/issues).

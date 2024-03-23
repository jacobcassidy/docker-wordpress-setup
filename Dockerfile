FROM wordpress:latest

# Install dependencies required for Composer + VIM
RUN apt-get update && apt-get install -y git unzip vim

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the Composer home directory
ENV COMPOSER_HOME=/usr/local/share/composer

# Add composer global bin directory to PATH, so the installed packages are available system-wide
ENV PATH="${PATH}:$COMPOSER_HOME/vendor/bin"

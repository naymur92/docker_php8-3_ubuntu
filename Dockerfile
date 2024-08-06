FROM ubuntu:20.04

# Install software-properties-common to add repositories
RUN apt-get update && \
    apt-get install -y software-properties-common \
    vim \
    nano \
    apache2-utils && \
    apt-get clean

# Add the ondrej/php repository which contains PHP 8.3 packages
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

# Update package lists again
RUN apt-get update

# Install curl, Apache, PHP 8.3, required PHP extensions and Node.js 20 with npm
RUN apt-get install -y curl apache2 php8.3 libapache2-mod-php8.3 openssl php8.3-bcmath php8.3-curl php8.3-common php8.3-mbstring php8.3-mysql php8.3-mysqli php8.3-tokenizer php8.3-xml php8.3-zip php8.3-soap && \
    curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Install Composer
RUN php -r "copy('https://composer.github.io/installer.sig', 'composer-setup.sig');" && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === trim(file_get_contents('composer-setup.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    php -r "unlink('composer-setup.sig');"

# Enable mod_rewrite for Laravel
RUN a2enmod rewrite

# Copy the virtual host configuration files
# COPY ./configs/apache/sites-available /etc/apache2/sites-available

# Enable the sites
# RUN a2ensite pauthadmin.test.conf
# RUN a2ensite ims.test.conf

# Expose port
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]

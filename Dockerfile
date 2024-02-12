FROM ubuntu:20.04

# Install software-properties-common to add repositories
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get clean

# Add the ondrej/php repository which contains PHP 8.3 packages
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

# Add NodeSource repository for Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

# Update package lists again
RUN apt-get update

# Install Apache, PHP latest, required PHP extensions, Node.js and npm
RUN apt-get install -y apache2 php8.3 libapache2-mod-php8.3 openssl php8.3-bcmath php8.3-curl php8.3-common php8.3-mbstring php8.3-mysql php8.3-mysqli php8.3-tokenizer php8.3-xml php8.3-zip php8.3-soap && \
    # curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    # apt-get install -y nodejs && \
    apt-get clean

# Install npm
RUN apt-get install -y npm

# Install Composer
RUN php -r "copy('https://composer.github.io/installer.sig', 'composer-setup.sig');" && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === trim(file_get_contents('composer-setup.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    php -r "unlink('composer-setup.sig');"

# Enable Apache modules
RUN a2enmod rewrite

# Expose port
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]

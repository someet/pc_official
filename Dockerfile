FROM daocloud.io/someetinc/pc_official_base:latest

# Copy the working dir to the image's web root
COPY . /var/www/html

# The following directories are .dockerignored to not pollute the docker images
# with local logs and published assets from development. So we need to create
# empty dirs and set right permissions inside the container.

# Composer packages are installed first. This will only add packages
RUN composer global require fxp/composer-asset-plugin:~1.1.3 --no-plugins  \
    && composer self-update --no-progress \
    && composer install --no-progress \
    && mkdir runtime web/assets \
    && chown www-data:www-data runtime web/assets

# Expose everything under /var/www (vendor + html)
# This is only required for the nginx setup
VOLUME ["/var/www"]

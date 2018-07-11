FROM openjdk:8-jdk

# Maintainers on this project are the following:
MAINTAINER Tobias Theobald <t.theobald@resolution.de>

RUN apt-get update \
    && apt-get install -y apt-transport-https

# Install the Atlassian Plugins SDK using the official Aptitude debian
# package repository
RUN echo "deb https://packages.atlassian.com/atlassian-sdk-deb stable contrib" >> /etc/apt/sources.list \
    && wget https://packages.atlassian.com/api/gpg/key/public \
    && apt-key add public \
    && rm public \
    && apt-get update \
    && apt-get install -y atlassian-plugin-sdk

# Copy Maven preference files to predefine the command line question about
# subscribing to the mailing list to `NO`.
COPY resources/.java /root/.java

# Install Node.js for web development dependencies
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs

# Create directory for sources using the same practice as the ruby images
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Set the default running command of the AMPS image to be running the
# application in debug mode.
CMD ["atlas-version"]

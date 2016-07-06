FROM ubuntu:14.04

MAINTAINER Raju Dawadi rajudawadinp@gmail.com

ENV DEBIAN_FRONTEND noninteractive

# Install Nodejs...
RUN apt-get update && apt-get install -y nodejs npm

# Installation of mongodb:
# Import MongoDB public GPG key AND create a MongoDB list file

RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

RUN echo "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen"

RUN apt-get update && apt-get -q -y install
CMD ["mongod", "--dbpath", "."]

# Expose port 27017 from the container to the host
EXPOSE 27017

# Create the MongoDB data directory
RUN mkdir -p /data/db

# Copy app to /src
COPY . /src

# Install app and dependencies into /src
RUN cd /src; npm install

#Show in our container
EXPOSE 8080

#Run the app
CMD cd /src && nodejs ./index.js
FROM ubuntu:14.04

MAINTAINER Raju Dawadi rajudawadinp@gmail.com

# It's necessary to avoid some problems:
# debconf: unable to initialize frontend: Dialog
ENV DEBIAN_FRONTEND noninteractive

# Install Nodejs...
RUN apt-get update && apt-get install -y nodejs npm
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
RUN apt-get update
RUN apt-get install -y mongodb-org
RUN service mongod start
# Copy app to /src
COPY . /src

# Install app and dependencies into /src
RUN cd /src; npm install

#Show in our container
EXPOSE 8080

#Run the app
CMD cd /src && nodejs ./index.js
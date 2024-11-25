##########################################################################
# Dockerfile to build Dynomite container images with Redis as the backend
# Based on Ubuntu
##########################################################################
# Copyright 2015 Netflix, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

##########################################################################

# Set the base image to Ubuntu
FROM ubuntu:18.04

# File Author / Maintainer
MAINTAINER Ioannis Papapanagiotou - dynomite@netflix.com

# Update the repository sources list and Install package Build Essential
RUN apt-get update && \
	export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y \
	autoconf \
	build-essential \
	dh-autoreconf \
	git \
	libssl-dev \
	libtool \
	software-properties-common \
	tcl8.5 

RUN echo 'holaasaaa'

# Clone the Dynomite Git
#RUN echo 'Cloning Dynomite Git'
RUN git clone https://github.com/iberovalia/dynomite

# Move to working directory
WORKDIR dynomite/

# Autoreconf
RUN autoreconf -fvi \
	&& ./configure --enable-debug=log \
	&& CFLAGS="-ggdb3 -O0" ./configure --enable-debug=full \
	&& make \
	&& make install

# Copy startup script
RUN echo 'copy file'
COPY scripts/startup.sh startup.sh
##################### INSTALLATION ENDS #####################

# Expose the peer port
EXPOSE 8101

# Expose the stats/admin port
EXPOSE 22222

# Default port to acccess Dynomite
EXPOSE 6379

# Get some environment variables
ENV REDIS_SERVER=redis:6379
ENV DATACENTER=dc1
ENV RACK=rack1
ENV LISTEN_ADDRESS=0.0.0.0:6379
ENV PEER_ADDRESS=0.0.0.0:8101
ENV DYNOMITE_SEED=

# Setting overcommit for Redis to be able to do BGSAVE/BGREWRITEAOF
RUN sysctl vm.overcommit_memory=1

# Set the entry-point to be the startup script
ENTRYPOINT ["/dynomite/startup.sh"]

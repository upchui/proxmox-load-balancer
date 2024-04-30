# syntax=docker/dockerfile:1
FROM alpine:latest

# Install git
RUN apk add --no-cache git

# Install python/pip
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --break-system-packages --no-cache --upgrade pip setuptools


# Download Proxmox-load-balancer fom github
RUN git clone https://github.com/cvk98/Proxmox-load-balancer.git

# Copy bootstrap skript
COPY bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh


# Install pip requirements
RUN pip3 install --break-system-packages -r /Proxmox-load-balancer/requirements.txt

# Set persist data VOLUME
RUN mkdir /config
VOLUME /config/

# Set workdir
WORKDIR /config/

# Start Proxmox-load-balancer
CMD ["sh", "/bootstrap.sh"]


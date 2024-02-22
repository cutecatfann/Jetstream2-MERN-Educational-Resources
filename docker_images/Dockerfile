# Author: Mimi Pieper
# Purpose: Create a Docker image with Node.js, MongoDB, and NGINX installed.
# Date: February 2024
# Version: 1.0
# Usage: docker build -t node-mongo-nginx .
#        docker run -p 80:80 -p 3000:3000 -d node-mongo-nginx

# Use the official Ubuntu 22.04 image as a base
FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    wget \
    nginx

# Install Node Version Manager (NVM) and Node.js
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR /root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install --lts

# Install MongoDB
RUN wget -nc https://www.mongodb.org/static/pgp/server-6.0.asc \
    && cat server-6.0.asc | gpg --dearmor | tee /etc/apt/keyrings/mongodb.gpg >/dev/null \
    && sh -c 'echo "deb [ arch=amd64,arm64 signed-by=/etc/apt/keyrings/mongodb.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" >> /etc/apt/sources.list.d/mongo.list' \
    && apt-get update \
    && apt-get install -y mongodb-org

# Start MongoDB service (it uses systemctl, so it needs to be started in the entry point.)
# RUN echo "sudo systemctl start mongod" > /start-mongo.sh \
#     && chmod +x /start-mongo.sh

# Expose ports (Node.js server and NGINX)
EXPOSE 80 3000

# Set a default command or entry point
CMD ["nginx", "-g", "daemon off;"]

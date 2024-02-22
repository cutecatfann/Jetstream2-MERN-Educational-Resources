# Student Docker Introduction

Docker is a powerful tool that allows developers to create, deploy, and run applications in a flexible and efficient manner. It uses containerization technology to bundle an application and its dependencies into a single object, called a container. 

Containers are lightweight and standalone, meaning they can run on any system that has Docker installed, regardless of the underlying operating system. This makes it easier to manage and distribute applications across different environments, from a developer's local machine to a production server.

For students, Docker can be an invaluable tool for learning and experimenting with different technologies. It allows you to quickly set up and tear down environments, try out new tools without cluttering your system, and work on projects with others in a consistent and reproducible manner.

To get started with Docker, you'll first need to install it on your system. Follow the instructions in the 'Student Docker Installation Instructions' section of this document.

## Student Docker Installation Instructions
1. Remove all conflicting packages
    ```bash
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
    ```

2. Install Docker Using Apt
    1. Add Docker's Official GPG Key
    ```bash
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    ```

    2. Add the Repository to Apt Sources
    ```bash
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    ```
    
    3. Install the Docker Packages
    ```bash
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    ```

    4. Verify the Installation
    ```bash
    sudo docker run hello-world
    ```

2. Pull the Docker Image
    ```bash
    docker pull cutecatfann/student-vm-setup:latest
    ```
3. Run a container using the pulled image:
```bash
docker run -d -p 80:80 -p 3000:3000 cutecatfann/student-vm-setup
```
Access the application via the VM's public IP address.

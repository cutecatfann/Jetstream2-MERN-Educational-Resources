# Student Instructions for Accessing the Instance
## Accessing Your Exosphere Instances
You can find the docs here for access [Access Instance Guide](https://docs.jetstream-cloud.org/ui/exo/access-instance/).
Open a terminal on your local machine.
For SSH Passphrase Authentication:
- To connect to the instance execute in your terminal `ssh exouser@<PUBLIC_IP>` where the `<PUBLIC_IP>` is the instance’s public IP address. This should be provided to you by your professor.
- When prompted, enter the exouser passphrase that was generated when your professor created the instance. Your professor should have shared it with you, ensure that you don't have extra lines, spaces, or characters at the end of thre passphrase.
- If you lose the passphrase, contact your professor for help.

# Instance Setup
Install Node and npm
    1. Install Node Version Manager (NVM)
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

    2. Activate NVM
    source ~/.bashrc

    3. Install the latest LTS version of Node.js
    nvm install --lts

    4. Check and make sure Node and npm are installed
    node -v
    npm -v

**Install MongoDB:**
      MongoDB is not available in Ubuntu’s default repositories. You can install it using MongoDB’s repositories.

      See the documentation [here](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/)

   - Import the MongoDB key using the package manager:
      ```bash
      sudo apt install gnupg2 
      
      wget -nc https://www.mongodb.org/static/pgp/server-6.0.asc 

      cat server-6.0.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/mongodb.gpg >/dev/null 
      ```
   - These commands will import the GPG key for the MongoDB repository, which is used to verify the authenticity of the packages in the repository.
      
   - Add the MongoDB repository to your system's package manager:
      ```bash
      sudo sh -c 'echo "deb [ arch=amd64,arm64 signed-by=/etc/apt/keyrings/mongodb.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" >> /etc/apt/sources.list.d/mongo.list' 
      ```
   - Update the package list:
      ```bash
      sudo apt update 
      ```

   - Install MongoDB:
      ```bash
      sudo apt install mongodb-org 
      ```
   - Start the MongoDB service:
      ```bash
      sudo systemctl start mongod  
      ```
   2. **Connect to MongoDB:**
      Connect to the MongoDB shell with the following command:
      ```bash
      mongosh
      ```

# How to upload the files
To upload the files to the Exosphere we are going to use Secure Copy Protocol (SCP):

1. Locate Your Files: Know the paths of the directories you want to upload.

2. Use SCP Command: On your local machine, open a terminal or command prompt. 

3. Use the scp command to upload directories. The command generally looks like this:
```bash
scp -r [local_directory_path] [username]@[instance_IP]:[remote_directory_path]
```

What the Options Mean:
- -r: Recursively copy entire directories.
- [local_directory_path]: The path to the directory on your local machine.
- [username]@[instance_IP]: Your SSH login info.
- [remote_directory_path]: Where you want to put the files on the Jetstream instance.

For example:
    
```bash
scp -r cs333-api-backend-main exouser@123.456.789.12:333app
```
It will then prompt you for your instance password. Copy the passphrase here


express
npm install -g express
express --version

cors
npm install -g cors

mongoose
nodemon
npm install -g nodemon

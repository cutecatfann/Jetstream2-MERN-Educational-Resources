# Student Instructions for Accessing the Instance
### Accessing Your Exosphere Instance
You can find the docs here for access [Access Instance Guide](https://docs.jetstream-cloud.org/ui/exo/access-instance/).
Open a terminal on your local machine.
For SSH Passphrase Authentication:
- To connect to the instance execute in your terminal `ssh exouser@<PUBLIC_IP>` where the `<PUBLIC_IP>` is the instance’s public IP address. This should be provided to you by your professor.
- When prompted, enter the exouser passphrase that was generated when your professor created the instance. Your professor should have shared it with you, ensure that you don't have extra lines, spaces, or characters at the end of thre passphrase.
- If you lose the passphrase, contact your professor for help.

# Instance Setup
### Install Node and npm
   1. Install Node Version Manager (NVM)
      ```bash
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
      ```

   2. Activate NVM
      ```bash
      source ~/.bashrc
      ```

   3. Install the latest LTS version of Node.js
      ```bash
      nvm install --lts
      ```

   4. Check and make sure Node and npm are installed
      ```bash
      node -v
      npm -v
      ```

### Install MongoDB: 

   MongoDB is not available in Ubuntu’s default repositories. You can install it using MongoDB’s repositories.

   See the documentation [here](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/)

   1. Import the MongoDB key using the package manager:
      ```bash
      sudo apt install gnupg2 
      
      wget -nc https://www.mongodb.org/static/pgp/server-6.0.asc 

      cat server-6.0.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/mongodb.gpg >/dev/null 
      ```
      - These commands will import the GPG key for the MongoDB repository, which is used to verify the authenticity of the packages in the repository.
      
   2.  Add the MongoDB repository to your system's package manager:
         ```bash
         sudo sh -c 'echo "deb [ arch=amd64,arm64 signed-by=/etc/apt/keyrings/mongodb.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" >> /etc/apt/sources.list.d/mongo.list' 
         ```
   3. Update the package list:
      ```bash
      sudo apt update 
      ```

   4. Install MongoDB:
      ```bash
      sudo apt install mongodb-org 
      ```
   5. Start the MongoDB service:
      ```bash
      sudo systemctl start mongod  
      ```
   6. Connect to the MongoDB shell with the following command:
      ```bash
      mongosh
      ```

## How to Upload Files
To upload the files to the Exosphere we are going to use Secure Copy Protocol (SCP):

   1. Locate Your Files: Know the paths of the directories you want to upload.

   2. Use SCP Command: On your local machine, open a terminal or command prompt. 

   3. Use the scp command to upload directories. The command generally looks like this:
      ```bash
      scp -r [local_directory_path] [username]@[instance_IP]:[remote_directory_path]
      ```

### What the Options Mean:
   - -r: Recursively copy entire directories.
   - [local_directory_path]: The path to the directory on your local machine.
   - [username]@[instance_IP]: Your SSH login info.
   - [remote_directory_path]: Where you want to put the files on the Jetstream instance.

   For example:
      ```bash
      scp -r cs333-api-backend-main exouser@123.456.789.12:333app
      ```
   
   4. It will then prompt you for your instance password. Copy the passphrase here

# Running the Code
### Installations
   1. First, `cd` into your project, and run `npm install` in order to add all the dependancies

   2. Create a `.env` file in the root of the project that contains the following:
      ```
      PORT: 3000
      NODE_ENV: development
      DB_CONNECT: mongodb://localhost:27017/cs333
      ```
### MongoDB

- On your local Mongo instance, create a new database named `cs333`. It can be empty when you first start the server. The `todo.js` file within the backend will auto populate the collection documents.

### Available Scripts

- In the project directory, you can run:
   ``` bash
   npm start
   ```

- It will report that it's running on port 3000 and which environment (production or development) that it's running in.
The server will also report whether it has connected to the MongoDB database. 

### Other Options
   ```bash
   npm run dev
   ```
- Does everything in the above script, but runs the server using `nodemon`. The server will automatically restart when it 
detects a change to the code. 

# NGINX
### Install NGINX:
   ```bash
   sudo apt install nginx
   ```
### Configure NGINX   
   NGINX will act as a reverse proxy to your Node.js server and serve your React app:

   1. Create a new configuration file in /etc/nginx/sites-available/:
      ``` bash
      sudo vim /etc/nginx/sites-available/myapp
      ```

   2. Add the following configuration (adjust paths and ports as necessary):
      ``` bash
            server {
            listen 80;
            server_name YOUR_IP_HERE;

            location / {
               root PATH_TO_BUILD;
               try_files $uri /index.html;
            }

            location /api/ {
               proxy_pass http://localhost:3000;
               proxy_http_version 1.1;
               proxy_set_header Upgrade $http_upgrade;
               proxy_set_header Connection 'upgrade';
               proxy_set_header Host $host;
               proxy_cache_bypass $http_upgrade;
            }
         }
      ```

   3. Enable the configuration by creating a symlink:
      ```bash
      sudo ln -s /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled/
      ```

   4. Test the NGINX configuration for errors: `sudo nginx -t`
   5. Restart NGINX: `sudo systemctl restart nginx`

# Final Steps
Open necessary ports on your Jetstream instance (typically port 80 for HTTP).

Test your application by accessing your server's public IP address or domain name in a web browser.

Remember to replace placeholders like `<your-repository-url>`, `<your-project-directory>`, `YOUR_NODE_SERVER_PORT`, and `/path/to/your/react-app` with actual values relevant to your project. 

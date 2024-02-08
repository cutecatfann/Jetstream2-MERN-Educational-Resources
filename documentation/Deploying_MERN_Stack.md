# Deploying a MERN Stack on Jetstream2

1. **Access Jetstream2:**
   - Log into Jetstream2 using your credentials. Follow the guide on how to set up and access the instances.

2. **Connect to Your VM:**
   - After your VM is running, connect to it via SSH. You'll need the IP address of the VM and the private key corresponding to the public key you used during setup. Or, if you are using the passphrase authentication option, use the passphrase. You can follow the steps in the previous guide for how to log in.

3. **Install Node.js and npm:**

   1. **Update Package List:**
      ```bash
      sudo apt update
      ```

   2. **Install Node.js:**
      You can install it locally, but you will need to update it.
      ```bash
      sudo apt install nodejs
      
      sudo npm install -g n
      
      sudo n lts
      
      node -v
      ```

      Check and see that your node version is at least 20+

   3. **Install NPM**
      ```bash
      sudo apt install npm
      ```   
      
   3. **Verify Installation:**
      After installation, you can verify it by checking the version of Node.js and npm:
      ```bash
      node -v
      
      npm -v
      ```

4. **Set MongoDB**

   1. **Install MongoDB:**
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

5. **Setting Up The React App**
   1. **Create React Project**   
      We are going to create the intital React project by using the `create react app` script
      ```bash
      npx create-react-app [YOUR_APP_NAME]
      ```
      Now, change into the newly created folder that contains the default React project template with all the dependencies installed
      ```bash
      cd [YOUR_APP_NAME]
      ```
      then, start the development web server
      ```bash
      npm start
      ```
      Then, see the result in the browser, it should be at `http://YOUR_INSTANCE_IP:3000`


6. **Deploy Your Frontend and Backend on the VM:**
   - Transfer your built React application and your backend code to your VM using SCP (Secure Copy Protocol) or a similar tool. SFTP (Secure File Transfer Protocal) works as well.
   - On the VM, serve your React build, typically from the Express server. You can serve static files (your React build) using Express.

7. **Run Your Application:**
   - Start your Express server on the VM. You can use a process manager like `pm2` to keep it running (`npm install pm2 -g`).

8. **Access Your Application:**
   - Once everything is up and running, you can access your application using the VM's IP address or a domain name pointed to that IP.

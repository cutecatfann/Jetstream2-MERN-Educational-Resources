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
      Node.js can be installed directly from Ubuntu's repositories, but it might not be the latest version. For the latest version, use the NodeSource repository:
      ```bash
      curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
      sudo apt-get install -y nodejs
      ```

      This will install Node.js 16.x and npm.

   3. **Verify Installation:**
      After installation, you can verify it by checking the version of Node.js and npm:
      ```bash
      node -v
      npm -v
      ```

4. **Set Up Backend with Express and MongoDB**

   1. **Install MongoDB:**
      MongoDB is not available in Ubuntu’s default repositories. You can install it using MongoDB’s repositories.

      See the documentation [here](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/)

      - Import the MongoDB key using the package manager:
      ```bash
      sudo apt-get install gnupg curl
      ```

      - OR: To import the MongoDB public GPG key:
      ```bash
      curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \ sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \ --dearmor
      ```
      - Create the list file `/etc/apt/sources.list.d/mongodb-org-7.0.list` for your version of Ubuntu

      - If you are using Ubuntu 22.04 (Jammy):
         - Run `echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list`
         - Reload the local packages `sudo apt-get update`
         - Install the latest stable version of Mongo DB
            ```bash
            sudo apt-get install -y mongodb-org
            ```
      - If you are using Ubuntu 20.04 (Focal):

         ```bash
         echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
         ```   
         - Reload the local packages `sudo apt-get update`
         - Install the latest stable version of Mongo DB
            ```bash
            sudo apt-get install -y mongodb-org
            ```
      - Start MongoDB:
      ```bash
      sudo systemctl start mongod
      ```

   2. **Verify MongoDB Installation:**
      Check the status of MongoDB to ensure it's running:
      ```bash
      sudo systemctl status mongod
      ```

   3. **Create a Directory for Your Express Application:**
      ```bash
      mkdir myapp
      cd myapp
      ```

   4. **Initialize a Node.js Project:**
      Initialize your Node.js project with a `package.json` file:
      ```bash
      npm init -y
      ```

   5. **Install Express and Mongoose:**
      Install Express and Mongoose (ODM for MongoDB):
      ```bash
      npm install express mongoose
      ```

   6. **Set Up Your Express Application:**
      Create a file for your server, e.g., `index.js`:
      ```bash
      touch index.js
      ```

      Open `index.js` with a text editor and write your basic server code. Here’s a simple example:
      ```javascript
      const express = require('express');
      const mongoose = require('mongoose');
      const app = express();
      const port = 3000;

      // Replace with your MongoDB connection string
      mongoose.connect('mongodb://localhost:27017/myapp', { useNewUrlParser: true, useUnifiedTopology: true });

      app.get('/', (req, res) => {
      res.send('Hello World!');
      });

      app.listen(port, () => {
      console.log(`Example app listening at http://localhost:${port}`);
      });
      ```

   7. **Run Your Express Server:**
      To start your server, run:
      ```bash
      node index.js
      ```

      Your Express server should now be running and connected to MongoDB. You can access it by visiting `http://[your_VM_IP]:3000` in a web browser. Remember to replace `[your_VM_IP]` with the actual public IP address of your Ubuntu instance on Jetstream2.

5. **Develop Your React Frontend:**
   - On your local machine, create a React application using `create-react-app`.
   - Develop your frontend, making sure to build it to interact with your backend (you can use `fetch` or `axios` for HTTP requests).
   - Once your frontend is ready, you can build it for production using `npm run build`.

6. **Deploy Your Frontend and Backend on the VM:**
   - Transfer your built React application and your backend code to your VM using SCP (Secure Copy Protocol) or a similar tool. SFTP (Secure File Transfer Protocal) works as well.
   - On the VM, serve your React build, typically from the Express server. You can serve static files (your React build) using Express.

7. **Run Your Application:**
   - Start your Express server on the VM. You can use a process manager like `pm2` to keep it running (`npm install pm2 -g`).
   - Open the necessary ports in your VM's firewall to allow traffic to your application (usually port 80 for HTTP and/or 443 for HTTPS).

8. **Access Your Application:**
   - Once everything is up and running, you can access your application using the VM's IP address or a domain name pointed to that IP.


## 1. Local Modifications to the Todo App 
First of all edit the code on your local machine

1. Disable `cors` in `backend/index.js` by commenting out the following lines:
    ```javascript
    import cors from 'cors'

    import { corsOptions } from './config/corsOptions.js'

    app.use(cors(corsOptions))
    ```

2. Replace `localhost:3000` with `api` in the whole code base by running the following command within the *root* directory:
    ```bash
    find frontend/src -type f -exec sed -i 's/http:\/\/localhost:3000/\/api/g' {} \;
    ```

    If you get an error about `invalid code f`, run the following instead: 
    ```bash
    find frontend/src -type f -exec sed -i '' 's/http:\/\/localhost:3000/\/api/g' {} \;
    ```

3. Build the local app
    1. `cd` into the `frontend` directory
    2. Run the folllowing to install all the requirements:
    ```bash
    npm install
    ```
    3. Run the following command to compile your react project into a `build` directory. This will be within the `frontend` directory:
    ```bash
    npm run build
    ```

4. Now, with the new modifications to the code, push your code back to Github
    ```bash
    git add .
    git commit -m "updated todo app to work with ngnix configuration"
    git push
    ```
## SSH into the Jetstream VM
We are going to use an Ubuntu VM running Ubuntu 20.04 through a service called Jetstream. This is a research service that provides VMs to universities who can use them. 

In this case, your professor set up VMs so that you get a public IP and can have a whole server.

You will access the VM through SSH or PuTTY intitally, then we will set up private/public keys to allow for ease of access.

### MacOS or Linux
1. Open a terminal, and type
    ```bash
    ssh exouser@<ip>
    ```
    where `<ip>` is the ip of the Jetstream instance that was allocated for you. 
2. You will asked if you want this to be added to the list of fingerprints, say yes. 
3. When asked, supply the password given to you, and make sure not to include any trailing spaces or line breaks. It will be a random string of words.

### Windows
For Windows, you can use either PuTTY or Git Bash to SSH into a server. Here's how:

**PuTTY**
1. Download and open PuTTY.
2. In the "Host Name (or IP address)" field, enter exouser@<ip>, where <ip> is the IP of the Jetstream instance that was allocated for you.
3. Click "Open" to start the SSH session.
4. If you see a security alert about the server's host key, click "Yes" to add the key to PuTTY's cache and continue connecting.
5. When asked, enter the password given to you.

**Git Bash**
1. Open Git Bash.
2. Type the following command:
    ```bash
    ssh exouser@<ip>
    ```
    where <ip> is the IP of the Jetstream instance that was allocated for you.
3. If you see a message about the authenticity of the host, type yes to continue connecting.
4. When asked, enter the password given to you.

## SSH Keys to VM
To save time with the VMs you can set up a key so that you do not need to enter a password every time, the key on your local machine will give you access to the VM. Note: to exit an SSH session in Ubuntu type `exit` in the VM and press enter.

### MacOS / Linux
1. In a terminal ON YOUR LOCAL MACHINE run `ssh-keygen`. Choose the default options. This will generate a key on your local machine
2. Then run the following on your local machine to copy the SSH key to your Jetstream instance. You should use the passphrase here to add it to your VM, but here on out when you use `ssh exouser@<ip>` you no longer need to enter a password.
    ```
    ssh-copy-id PATH_TO_KEY exouser@<ip> 
    ```
3. Test if the new key was successfully added by logging into the server with `ssh exouser@<ip>`

### Windows
1. In a terminal ON YOUR LOCAL MACHINE using **command prompt** run `ssh-keygen`. Choose the default options. This will generate a key on your local machine
2. Then run the following on your local machine to copy the SSH key to your Jetstream instance. This command should be run in **git bash**. You should use the passphrase here to add it to your VM, but here on out when you use `ssh exouser@<ip>` you no longer need to enter a password.
    ```
    ssh-copy-id exouser@<ip> 
    ```
3. Test if the new key was successfully added by logging into the server with `ssh exouser@<ip>` usng **git bash**

## Installing Requirements on the VM
To set up the server we need to install all the requirements on the Jetstream VM. Run all of the following on the Jetstream instance, make sure you are SSHed into the server:

1. To update all the packages to be up to date run:
    ```
    sudo apt update
    sudo apt-get upgrade -y
    ```
    This tells apt, the package manager, to go get information about the latest packages and upgrade to the latest versions.

2. Check that a non-GUI text editor is installed (VIM, Nano, Emacs):
    ```bash
    vim --verson
    nano --version
    ```
    To use Vim, just type `vi filename` where `filename` is the name of the file you want to be opened. To edit a file in Vim type `i`. To save and quit Vim type `esc` then `:wq`.

3. Make sure that Ubuntu is up to date:
    ```bash
    sudo apt dist-upgrade -y
    ```

4. Now, you need to install some needed tools. The following command installs nginx, git, and some packages for MongoDB. You can run the install commands separately or together
    ```bash
    sudo apt install nginx build-essential gnupg curl
    ```
    ```bash
    sudo apt install gnupg
    sudo apt install build-essential
    sudo apt install nginx
    sudo apt install curl
    ```

5. Now, install MongoDB. The below command will add the keys for the MongoDB repository so that apt is able to verify the source
    ```
    curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
    sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
    --dearmor
    ```
6. Run the following command to add the MongoDB project's repository as a source for apt to use to install
    ```
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
    ```
7. Run the following command to update apt's package list to be able to install MongoDB from the repository added:
    ```
    sudo apt update
    ```
8. Install MongoDB
    ```
    sudo apt install -y mongodb-org
    ```
9. Start the MongoDB server on your Ubuntu VM. This command tells the VM to run whenever the VM is running in the background
    ```
    sudo systemctl enable mongod && sudo systemctl start mongod
    ```
10. Open the MongoDB shell with `mongosh`
11. In the MongoDB shell, create a new database
    ```
    use cs333
    ```
12. Exit the MongoDB shell with `CTRL+C, CTRL+C` 

## Install NVM, NPM, and Node
Now, the package managers for node, nvm and npm need to be installed along with Node for the React project to run

1. Run the following command to download the nvm install script and pipes it to bash in order to run it
    ```
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    ```
2. After running the previous command either log out of SSH and then log back in in order to add nvm to $PATH, or run the following command:
    ```
    exec bash
    ```
3. The following command will install npm and force nvm to run version 20. You can run them separately or together, the `&&` bash command will run everything after it as long as everything preceeding run successfully.
    ```
    nvm install 20 && nvm use 20
    ```
4. Check the version by running
    ```
    node -v
    npm -v
    ```

## Getting the Repo from GitHub
Jetstream needs to be connected to your GitHub account in order to get the code onto the server.

1. Create a new SSH key on the server which will be used for all GitHub interactions. 
    - Keep the default file, and set any passphrase
    ```
    ssh-keygen
    ```
2. Get the public key, and copy it
    ```
    cat .ssh/id_rsa.pub
    ```
3. Open your browser on your local machine and make sure you are logged into GitHub. Add the public key you copied as a new authentication key at https://github.com/settings/keys
4. In your Jetstream VM, clone the todo repo to the server. Make sure to replace with the actual repo name. Once it is cloned, `cd` into the folder that was created, this is the root of your project.
    ```
    git clone git@github.com:REPONAME.git
    ``` 

## Configuring Nginx
**What is nginx?**\
Nginx (pronounced "engine-x") is a popular open-source web server and reverse proxy server. It's known for its high performance, stability, rich feature set, simple configuration, and low resource consumption.

**How it works:**

**Web Server:** As a web server, Nginx can serve static content directly to clients. When a client sends a request, Nginx looks for the requested file in the server's file system and sends it back to the client.

**Reverse Proxy:** As a reverse proxy, Nginx can handle requests on behalf of one or more backend servers (like the Node.js server we are using here). It accepts client requests, forwards them to the appropriate server, and then returns the server's response to the client. This can help distribute load, provide additional security, or enable more complex configurations.

In the provided configuration, Nginx is set up to listen on port 80 and forward requests that start with /api to a backend server running on http://127.0.0.1:3000/. The proxy_set_header directives are used to pass along certain HTTP headers to the backend server.

**Setting up Nginx**
1. First, the default configuration needs to be removed: 
    ```bash
    sudo unlink /etc/nginx/sites-enabled/default
    ```
2. Use `vim` or the text editor of your choice to create a new configuration at `/etc/nginx/sites-available/todo` with the following contents. 
    - The command for Vim is `vi /etc/nginx/sites-available/todo`
    - NOTE: Please make sure to update the path `root /home/exouser/todo/frontend/build;` with your actual path to the build directory from the root level in your VM.
    - Replace the server_name from wach.quest to the actual URL of the Jetstream instance you will be provided by your professor

    ```javascript
    server {
        listen 80;
        server_name wach.quest;
        
        location /api {
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
            proxy_pass http://127.0.0.1:3000/;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
        }
        location /api/ {
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
            proxy_pass http://127.0.0.1:3000/;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
        }
            location / {
            root /home/exouser/todo/frontend/build; 
            try_files $uri $uri/ =404;
        }
    }
    ```

3. Now, you have to ensure to match the name of a diretory on the VM. From `/path/frontend`, run the following to put the already-built front end in the correct folder:
    ```
    sudo cp -r build/* /var/www/html/
    ```

4. Now link this to /etc/nginx/sites-enabled to make this the active configuration.
    ```bash
    sudo ln -s /etc/nginx/sites-available/todo /etc/nginx/sites-enabled/
    ```

5. To test your configuration, run the following:
    ```bash
    sudo nginx -t
    ```

6. To enable and start nginx, run the following: 

    ```bash
    sudo systemctl enable nginx && sudo systemctl start nginx
    ```
    ```
    # or run
    sudo systemctl enable nginx
    sudo systemctl start nginx
    ```

## Running the App
As of now the server should be serving (running) on the front end. If you visit the IP/URL you should see a static web app with no backend. This is because there is nothing to pass the API requests to. Node needs to be run in a terminal for API requests to work.

1. `cd` into the backend folder and run `npm install` and `npm run start`. 

## Security Certs
In order to not get the `not secure` error on your website, you have to set up a public cert. Here, we will use certbot, which will give you a free secure certification for three months, when you will need to renew it.
1. In your VM, install the certbot libary:
    ```bash
    sudo apt install python3-certbot-nginx
    ```
2. Get a certificate by running the below command
    - Make sure to use a valid email in the command
    - IMPORTANT: Make sure the domain.com directly matches the URL of your Jetstream instance. This should have been shared with you from your professor. This must match EXACTLY, do not include any `http` or `https` in the URL

    ```bash
    sudo certbot --nginx --redirect --agree-tos --no-eff-email -m YOUREMAIL@MAIL.com -d YOURDOMAIN.com -d www.YOURDOMAIN.com
    ``` 

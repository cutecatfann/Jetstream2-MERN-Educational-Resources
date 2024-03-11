## Modifying ToDo App
On Your local machine
## replace references to localhost

```
find frontend/src -type f -exec sed -i 's/http:\/\/localhost:3000/\/api/g' {} \;
```



## building the front end

`cd` into the `frontend` directory, and run 
```
npm install
```
to install all the requirements, and 
```
npm run build
```
to compile your react project into a `build` directory. This will be within the `frontend` directory.

## SSH into the Jetstream VM
### MacOS or Linux
__ON YOUR LOCAL COMPUTER__


```
ssh exouser@<ip>
```
where `<ip>` is the ip of the jetstream instance Mimi and Bernie allocated for you. 

When asked, supply the password given to you, and make sure not to include any trailing spaces or line breaks.

### Windows
PuTTY
GitBash

## SSH Keys to VM
### ssh-copy-id

So you don't have to enter your password every time, you can copy over your ssh keys. If you don't have keys generated already, run `ssh-keygen` to generate a local identity, then __on your local machine__ 
```
ssh-copy-id exouser@<ip> 
```
This will copy an SSH key to your jetstream instance, so now when you use `ssh exouser@<ip>`, you won't have to enter a password. 
To exit an SSH session, type `exit` and press enter. 

## Installing Requirements on the VM
__on your jetstream instance__ run the following

```
sudo apt update
```
This tells apt, the package manager, to go get information about the latest packages.

---

```
sudo apt install nginx build-essential gnupg curl
```
This installs nginx, as well as git and other necessary tools which are needed to install mongoDB. 

---

```
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
```
This adds the keys for the mongoDB repository, so that apt can be sure it's installing packages from a legitimate source.

---

```
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
```
This adds the mongoDB project's repository as a source for apt. 

---

```
sudo apt update
```
This again updates apt's list of packages, so that it can install from the repository you just added. 

---

```
sudo apt install -y mongodb-org
```
This installs mongoDB.

---

```
sudo systemctl enable mongod && sudo systemctl start mongod
```
This tells Ubuntu that you want the mongoDB server to run whenever your virtual machine is running, and starts it in the background. 

---

To verify that you have successfully installed and started mongodb, you can open the mongo shell with `mongosh`. 

## nvm, npm and node

__These steps and all that follow are to be run on your jetstream instance.__

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```
This downloads the nvm install script and pipes it into bash to run it. 

__after this step, log out of ssh and log back in so that nvm will be in your $PATH.__

Finally, use nvm to install and run your desired version: 

```
nvm install 20 && nvm use 20
```
Note: `&&` runs everything after it, as long as everything before it ran successfully. 

## pulling in your repo with git

First, we need to give your jetstream instance access to your github account. 
```
ssh-keygen
```
This will generate SSH keys for your server.
```
cat .ssh/id_rsa.pub
```
This will spit out the public key you just generated for your jetstream instance. 
In a web browser on your local machine, copy and paste it into a new authentication key at https://github.com/settings/keys.

Next, clone the relevant repository onto the jetstream VM. 
```
git clone git@github.com:SOU-Boscoe/lab9-<your-username>.git
```
where `<your-username>` is your github username. 
`cd` into the folder that was created. This is your project root. 

## Disable cors in backend/index.js

Go in there in vim and comment out the line that tells express to use the cors middleware. 

## configuring nginx

First, we will remove the default configuration: 
```
sudo unlink /etc/nginx/sites-enabled/default
```

Next, use `vim` or the text editor of your choice to create a new configuration at `/etc/nginx/sites-available/todo` with the following contents: 

```
server{
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
        root /home/exouser/lab9-chandlercampbell/frontend/build; 
        try_files $uri $uri/ =404;
    }
}
```
__Note that there's something here you need to set to match the name of a directory on your VM.__
There's too much here to go into in detail, but suffice it to say that nginx is looking for requests coming in to /api/{something} and is sending those to node.js. Anything else, it's serving from the build directory we created earlier. 

Now we link this to /etc/nginx/sites-enabled to make this the active configuration.
```
sudo ln -s /etc/nginx/sites-available/todo /etc/nginx/sites-enabled/
```

To test your configuration, run the following:
```
sudo nginx -t
```

To enable and start nginx, we can run the following: 

```
sudo systemctl enable nginx && sudo systemctl start nginx
```


## running node.js

Your server should now be serving the front end, but it has nothing to pass api requests off to. We must run node in a terminal for api requests to work. 
`cd` into the backend folder within your project root and run `npm install` and `npm run start`. 

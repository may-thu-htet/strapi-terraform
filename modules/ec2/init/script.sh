#!/bin/bash

# Preparing for PgAdmin4
# Read: https://www.pgadmin.org/download/pgadmin-4-apt/
# Install the public key for the repository (if not done previously):
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg

# Create the repository configuration file:
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

#
# Install pgAdmin
#

# Install for web mode only: 

sudo apt install pgadmin4-web -y

# 
# Install Nodejs
# 
# Read: https://docs.strapi.io/developer-docs/latest/setup-deployment-guides/deployment/hosting-guides/amazon-aws.html#_3-install-node-js-with-npm
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
...
sudo apt-get install nodejs -y
node -v && npm -v > /home/ubuntu/01-node_version.txt

# 
# Install PM2
# 
# Read: https://docs.strapi.io/developer-docs/latest/setup-deployment-guides/deployment/hosting-guides/amazon-aws.html
sudo npm install pm2@latest -g

# 
# clone project
# 
# https://docs.strapi.io/developer-docs/latest/setup-deployment-guides/deployment/hosting-guides/amazon-aws.html#_5-deploy-from-github
cd /home/ubuntu

sudo git clone https://github.com/may-thu-htet/strapi-test.git

# generate ecosystem.config.js
# https://docs.strapi.io/developer-docs/latest/setup-deployment-guides/deployment/hosting-guides/amazon-aws.html#_6-install-pm2-runtime
cat <<EOF > ecosystem.config.js
module.exports = {
  apps: [
    {
      name: '${app_name}', // Your project name
      cwd: '${cwd}', // Path to your project
      script: 'npm', // For this example we're using npm, could also be yarn
      args: 'start', // Script to start the Strapi server, `start` by default
      env: {
        NODE_ENV: 'production',
        DATABASE_HOST: '${host}', // database Endpoint under 'Connectivity & Security' tab
        DATABASE_PORT: '${port}',
        DATABASE_NAME: '${db_name}', // DB name under 'Configuration' tab
        DATABASE_USERNAME: '${db_username}', // default username
        DATABASE_PASSWORD: '${db_password}',
        AWS_ACCESS_KEY_ID: '${aws_access_key}',
        AWS_ACCESS_SECRET: '${aws_access_secret}',
        AWS_REGION: 'ap-northeast-1',
        AWS_BUCKET_NAME: '${s3_bucket}',
      },
    },
  ],
};
EOF

# strapi new my-project --quickstart --no-run && cd my-project/ && npm install pg @strapi/provider-upload-aws-s3


cd /home/ubuntu/strapi-test/my-project
sudo npm install
sudo npm install pg @strapi/provider-upload-aws-s3
NODE_ENV=production npm run build


# https://docs.strapi.io/developer-docs/latest/setup-deployment-guides/deployment/hosting-guides/amazon-aws.html#_6-install-pm2-runtime
cd ../..
pm2 start /home/ubuntu/ecosystem.config.js > /home/ubuntu/02-start_log.txt

pm2 ls > /home/ubuntu/03-process_log.txt

# 
# pm2 auto-restart on ec2 reboot script
# 
# pm2 startup >/home/ubuntu/04-startup_log.txt
# sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu >05-env_setup.txt
# pm2 save >/home/ubuntu/pm2_save.txt

# 
# Setup PgAdmin4 web-version for Postgres  
# 

# sudo /usr/pgadmin4/bin/setup-web.sh

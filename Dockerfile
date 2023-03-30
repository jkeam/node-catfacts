FROM registry.access.redhat.com/ubi9/nodejs-16@sha256:dbd1762115eb81fe8818bd0209f12f77b106d2b51ca230666dbd1534d84aa895

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --omit=dev

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "node", "app.js" ]

FROM registry.access.redhat.com/ubi9/nodejs-16:1-143

USER root

RUN yum install postgresql-devel redhat-rpm-config -y

ENV PORT 3000
ENV DB_URL postgres://catuser:catuserpassword@localhost:5432/catfacts

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --omit=dev

# Bundle app source
COPY . .

EXPOSE ${PORT}

USER 1001
CMD [ "node", "app.js" ]

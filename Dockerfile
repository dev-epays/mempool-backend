FROM node:16.16.0-buster-slim

RUN useradd -m mempool && mkdir /home/mempool/app

# Create app directory
WORKDIR /home/mempool/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --omit=dev

# Bundle app source
COPY . .

RUN npm run build

USER mempool
EXPOSE 8999
CMD [ "sh", "start.sh" ]
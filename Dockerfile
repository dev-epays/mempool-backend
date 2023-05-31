FROM node:16.16.0-buster-slim

RUN useradd -m mempool
USER mempool
RUN mkdir /home/mempool/app
WORKDIR /home/mempool/app
COPY --chown=mempool:mempool package*.json ./

RUN npm install
COPY --chown=mempool:mempool . .
RUN npm run build
EXPOSE 8999

CMD [ "sh", "start.sh" ]
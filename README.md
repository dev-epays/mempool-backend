# Mempool Backend

docker-compose example
```
version: "3.7"

services:
  core:
    build: git@github.com:dev-epays/litecoin-core-docker.git#main
    environment:
      RPC_USER: "litecoin"
      RPC_PASSWORD: "litecoin"
    volumes:
      - /home/blockchain/.litecoin:/home/litecoin/.litecoin
  electrum:
    build: git@github.com:dev-epays/electrumx-docker.git#main
    environment:
      COIN: "Litecoin"
      DB_DIRECTORY: "/home/electrumx/db/"
      DAEMON_URL: "http://litecoin:litecoin@core:9332/"
      SERVICES: "tcp://0.0.0.0:50002"
    volumes:
      - /home/blockchain/blockchains/litecoin/db:/home/electrumx/db
    depends_on:
      - core
  api:
    build: ./
    environment:
      MEMPOOL_BACKEND: "electrum"
      CORE_RPC_HOST: "core"
      CORE_RPC_PORT: "9332"
      CORE_RPC_USERNAME: "litecoin"
      CORE_RPC_PASSWORD: "litecoin"

      ELECTRUM_HOST: "electrum"
      ELECTRUM_PORT: "50002"
      ELECTRUM_TLS_ENABLED: "false"

      DATABASE_ENABLED: "false"
      STATISTICS_ENABLED: "true"
    restart: on-failure
    depends_on:
      - electrum
      - core
    stop_grace_period: 1m
    volumes:
      - ./data:/usr/src/app/cache
    ports:
      - "8999:8999"
```

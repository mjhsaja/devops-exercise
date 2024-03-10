FROM node:20.9.0-bullseye-slim

WORKDIR /opt/app

COPY . .

RUN npm install

ENTRYPOINT [ "node", "index.js" ]
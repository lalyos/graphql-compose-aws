FROM node:9-alpine
ADD . /app/
WORKDIR /app

RUN npm install

CMD ["./node_modules/.bin/babel-node", "./examples/cli/index.js"]

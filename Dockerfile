FROM node:9-alpine
ADD . /app/
WORKDIR /app

RUN npm install

LABEL io.cmd.description="AWS Cloud API via GraphQL"
CMD ["./node_modules/.bin/babel-node", "./examples/cli/index.js"]

FROM node:9-alpine
RUN apk add --no-cache bash

ADD . /app/
WORKDIR /app

RUN npm install

LABEL io.cmd.description="AWS Cloud API via GraphQL"
ADD docker-entrypoint /
ENTRYPOINT ["/docker-entrypoint"]

FROM node:9-alpine
RUN apk add --no-cache bash

ADD . /app/
WORKDIR /app

RUN npm install

RUN sed  "s/#HACKED/$(sed -n 'H;${x;s/\n/\\\\\\\\n/g;p}' defaultQuery)/" renderGraphiQL.js > ./node_modules/express-graphql/dist/renderGraphiQL.js

LABEL io.cmd.description="AWS Cloud API via GraphQL"
ADD *.graphql /app/
ADD docker-entrypoint /
ENTRYPOINT ["/docker-entrypoint"]

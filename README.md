# AWS Cloud API via GraphQL 

## Usage

### Demo webserver

To get familiar with GraphQL, its probably best to start with an interactive web interface:

```
docker run -p 4000:4000 lalyos/graphql-aws --demo
```

You can play with GraphiQL on [http://localhost:4000](http://localhost:4000). It has autocompletion on **Ctrl-Space**

### Cli
```
graphql() { 
  docker run -i --rm \
    -e AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY \
    -e AWS_DEFAULT_REGION \
    lalyos/graphql-aws 
}
```

```
$ cat > instances.graphql << "EOF"
query instances($AWS_DEFAULT_REGION: String, $AWS_ACCESS_KEY_ID: String, $AWS_SECRET_ACCESS_KEY: String) {
  aws(config: {accessKeyId: $AWS_ACCESS_KEY_ID, secretAccessKey: $AWS_SECRET_ACCESS_KEY, region: $AWS_DEFAULT_REGION}) {
    ec2 {
      describeInstances {
        Reservations {
          Instances {
            InstanceId
            PublicIpAddress
            VpcId
          }
        }
      }
    }
  }
}
EOF
```

```
$ graphql < instances.graphql

## format output with jq
$ cat instances.graphql | graphql | jq .
```

## GraphiQL customization

I wanted to have a customized graphiQL editor, where I can change the initial 
sample query displayed as a comment in the left pane of the browser.

- See **defaultQuery** props in [GraphiQL Usage](https://github.com/graphql/graphiql#usage)
-  the [express-graphql
   module](https://github.com/graphql/express-graphql/blob/d15099bf91774ffae234be6d1fdee8ecb3ac9520/src/renderGraphiQL.js#L154-L158)
   doesnt specifies it.

The minified version of the renderGraphiQL.js gets installed into ./node_modules/express-graphql/dist/renderGraphiQL.js

So the original [defaultQuery](https://github.com/graphql/graphiql/blob/476aa2d8380e3d3d83f63ae7fda4347fb8b52e1a/src/components/GraphiQL.js#L999)
is copied into a local file **defaultQuery** ant the modifies version is getting
inserted into **./node_modules/express-graphql/dist/renderGraphiQL.js** by sed magic in
[Dockerfile](https://github.com/lalyos/graphql-compose-aws/blob/master/Dockerfile#L9) 

# AWS Cloud API via GraphQL 

## Usage

### Demo webserver

To get familiar with GraphQL, its probably best to start with an interactive web interface:

```
docker run -p 4000:4000 lalyos/graphql-aws npm run demo
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

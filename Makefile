
docker-build:
	(sed '/^ADD \. \/app/ Q' Dockerfile; cat Dockerfile.multiadd ; sed '1,/^ADD \. \/app/ d ' Dockerfile) > Dockerfile.cacheable
	docker build -f Dockerfile.cacheable -t lalyos/graphql-aws .

.PHONY: dockerfile

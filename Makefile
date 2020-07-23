all:
	cp subtemplate-src/aadNestedTemplate.md admin
	cp subtemplate-src/aadNestedTemplate.md cluster
	cp subtemplate-src/aadNestedTemplate.md dynamic-cluster
	cp subtemplate-src/dbTemplate.md admin
	cp subtemplate-src/dbTemplate.md cluster
	cp subtemplate-src/dbTemplate.md dynamic-cluster
	cp subtemplate-src/appGatewayNestedTemplate.md cluster
	cp subtemplate-src/cluster-deletenode.md cluster/deletenode.md
	cp subtemplate-src/dynamic-cluster-deletenode.md dynamic-cluster/deletenode.md


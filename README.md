### Configure
```shell
export TOMCAT_VERSION=9.0.44
export FORTIFY_SSC_VERSION=20.2.0
```

### Build
```shell
docker build \
    -t ${REGISTRY}/fortify/ssc:${FORTIFY_SSC_VERSION} \
    --build-arg REGISTRY=${REGISTRY} \
    --build-arg TOMCAT_VERSION=${TOMCAT_VERSION} \
    --build-arg FORTIFY_SSC_VERSION=${FORTIFY_SSC_VERSION} \
    .
```

### Push
```shell    
docker push ${REGISTRY}/fortify/ssc
```

### Run
```shell
docker run -it --rm --init \
    --name=fortify-ssc \
    -v fortify-data:/var/lib/tomcat \
    -p 8080:8080 \
    ${REGISTRY}/fortify/ssc:${FORTIFY_SSC_VERSION}
```

### Configure
```shell
export FORTIFY_SSC_VERSION=20.2.0
export MYSQL_CONNECTOR_VERSION=8.0.23

wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar
```

### Build
```shell
docker build \
    -t ${REGISTRY}/fortify-ssc:${FORTIFY_SSC_VERSION} \
    --build-arg REGISTRY=${REGISTRY} \
    --build-arg FORTIFY_SSC_VERSION=${FORTIFY_SSC_VERSION} \
    --build-arg MYSQL_CONNECTOR_VERSION=${MYSQL_CONNECTOR_VERSION} \
    .
```

### Push
```shell    
docker push ${REGISTRY/fortify-ssc
```

### Run
```shell
docker run -it --rm --init \
    --name=fortify-ssc \
    -v fortify-data:/opt/tomcat/.fortify \
    -p 8080:8080 \
    ${REGISTRY}/fortify-ssc:${FORTIFY_SSC_VERSION}
```

ARG REGISTRY
ARG REDHAT_VERSION=8.3
ARG TOMCAT_VERSION=9.0.41

FROM ${REGISTRY}/redhat/ubi/ubi8:${REDHAT_VERSION} as build

ARG FORTIFY_SSC_VERSION
ARG FORTIFY_SSC_PACKAGE=Fortify_${FORTIFY_SSC_VERSION}_Server_WAR_Tomcat.zip

COPY [ "${FORTIFY_SSC_PACKAGE}", "/tmp/" ]

RUN yum install -y unzip && \
    unzip -j "/tmp/${FORTIFY_SSC_PACKAGE}" "ssc.war" -d "/tmp/"

###############################################################################
FROM ${REGISTRY}/apache/tomcat:${TOMCAT_VERSION}

ARG MYSQL_CONNECTOR_VERSION
ARG MYSQL_CONNECTOR_JAR=mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar

COPY --chown=1001:1001 [ "${MYSQL_CONNECTOR_JAR}", "${TOMCAT_HOME}/lib/" ]

COPY --from=build --chown=1001:1001 [ "/tmp/ssc.war", "${TOMCAT_HOME}/webapps/fortify.war" ]

RUN mkdir -p ${TOMCAT_HOME}/.fortify
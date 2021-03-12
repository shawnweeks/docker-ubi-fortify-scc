ARG REGISTRY
ARG REDHAT_VERSION=8.3
ARG TOMCAT_VERSION

FROM ${REGISTRY}/redhat/ubi/ubi8:${REDHAT_VERSION} as build

ARG FORTIFY_SSC_VERSION
ARG FORTIFY_SSC_PACKAGE=Fortify_${FORTIFY_SSC_VERSION}_Server_WAR_Tomcat.zip

COPY [ "${FORTIFY_SSC_PACKAGE}", "/tmp/" ]

RUN yum install -y unzip && \
    unzip -j "/tmp/${FORTIFY_SSC_PACKAGE}" "ssc.war" -d "/tmp/"

###############################################################################
FROM ${REGISTRY}/apache/tomcat:${TOMCAT_VERSION}

USER root

# Required by Fortify for Report Generation
RUN yum install -y fontconfig && \
    yum clean all

COPY --from=build --chown=root:${TOMCAT_GROUP} [ "/tmp/ssc.war", "${TOMCAT_INSTALL_DIR}/webapps/fortify.war" ]
COPY --chown=root:${TOMCAT_GROUP} [ "catalina.policy", "${TOMCAT_INSTALL_DIR}/conf/" ]

RUN chmod 644 ${TOMCAT_INSTALL_DIR}/conf/catalina.policy

USER ${TOMCAT_USER}

RUN mkdir -p ${TOMCAT_HOME}/.fortify/fortify/logs
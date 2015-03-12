# Artifactory
#
# Version Artifactory-3.5.2.1
#
# See https://github.com/joemccall86/docker-artifactory
#

FROM centos:6
MAINTAINER Michael Ferguson <mpherg@gmail.com>

ENV ARTIFACTORY_VERSION 3.5.2.1
ENV ARTIFACTORY_INSTALL /opt/jfrog
ENV DOWNLOAD_URL        https://bintray.com/artifact/download/jfrog/artifactory/artifactory-
ENV RUN_USER            daemon
ENV RUN_GROUP           daemon

RUN yum install -y java-1.8.0-openjdk-headless wget unzip                     \
 && mkdir -p ${ARTIFACTORY_INSTALL}                                           \
 && wget -nv ${DOWNLOAD_URL}${ARTIFACTORY_VERSION}.zip                        \
 && unzip -d ${ARTIFACTORY_INSTALL} artifactory-${ARTIFACTORY_VERSION}.zip

RUN mkdir -p /var/artifactory-data \
 && ln -sf /var/artifactory-data ${ARTIFACTORY_INSTALL}/artifactory-${ARTIFACTORY_VERSION}/data

# Expose the default endpoint
EXPOSE 8081

# Run the embedded tomcat container
ENTRYPOINT ${ARTIFACTORY_INSTALL}/artifactory-${ARTIFACTORY_VERSION}/bin/artifactory.sh

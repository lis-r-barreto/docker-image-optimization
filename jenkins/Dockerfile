FROM alpine:3.17

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]

EXPOSE 8080 443 50000

ENV USER jenkins
ENV GROUP ${USER}
ENV JENKINS_VERSION 2.411
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_WAR_PATH /usr/share/jenkins
ENV JENKINS_WAR_URL https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war
ENV JENKINS_PLUGIN_MANAGER https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.12.11/jenkins-plugin-manager-2.12.11.jar
ENV BIN_PATH /usr/local/bin
ENV REF_PATH ${JENKINS_WAR_PATH}/ref
ENV COPY_REFERENCE_FILE_LOG ${JENKINS_HOME}/copy_reference_file.log
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false \
              -Djava.awt.headless=true \
              -Dorg.apache.commons.jelly.tags.fmt.timeZone=America/Sao_Paulo \
              -Duser.home=$JENKINS_HOME \
              -Xms512m -Xmx2g

LABEL \
    br.puc.co.image.name="Jenkins master image" \
    br.puc.co.image.description="Image to build jenkins master - (Container and Orchestration)" \
    br.puc.co.image.author="Lis Barreto" \
    br.puc.co.image.version="${JENKINS_VERSION}"

WORKDIR ${JENKINS_HOME}

# Create directories
RUN mkdir -p ${JENKINS_HOME} ${REF_PATH}/init.groovy.d && \
# Install official packages
    apk add --no-cache ca-certificates openjdk17 openssh coreutils sudo bash vim curl git gnupg musl-locales tzdata zip iptables\
    musl-locales-lang btrfs-progs traceroute parallel docker netcat-openbsd bind-tools xz aws-cli ttf-dejavu groff && \
## Create users
    addgroup -g 1000 ${GROUP} && \
    adduser -h ${JENKINS_HOME} -u 1000 -G ${GROUP} -s /bin/bash -D ${USER} && \
    addgroup ${USER} docker && \
# Install Other packages
    ## kubectl
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/bin/kubectl

# Download jenkins files
ADD ${JENKINS_WAR_URL} ${JENKINS_WAR_PATH}/jenkins.war
ADD ${JENKINS_PLUGIN_MANAGER} ${JENKINS_HOME}/jenkins-plugin-manager.jar

# Install jenkins plugins
COPY conf/* ${REF_PATH}/
RUN java -jar ${JENKINS_HOME}/jenkins-plugin-manager.jar -f ${REF_PATH}/plugins.txt --verbose

# Hardening
COPY scripts/* ${BIN_PATH}/
RUN ${BIN_PATH}/hardening.sh && \
# Copy files to container from local repository and internet
    mv ${REF_PATH}/*.groovy ${REF_PATH}/init.groovy.d/ && \
# Chaging ownership of all files necessary to Jenkins works
    chown ${USER}: ${JENKINS_HOME} ${JENKINS_WAR_PATH} ${BIN_PATH} -R

USER jenkins
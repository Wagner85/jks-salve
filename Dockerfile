FROM ubuntu:20.04
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
   
LABEL maintainer="Scheduler Center Slave version 1.0"

# Make sure the package repository is up to date.
RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy git && \
# Install a basic SSH server
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
# Install JDK 8 (latest stable edition at 2019-04-01)
    apt-get install -qy openjdk-8-jdk && \
# Install essencial
    apt-get install -qy vim && \
    apt-get install -qy python3-pip && \
    apt-get install -qy build-essential libssl-dev libffi-dev python3-dev && \
    apt-get install -qy mtr && \
    apt-get install -qy telnet && \
    apt-get install -qy iputils-ping && \
    apt-get install -qy tcpdump && \
    apt-get install -qy net-tools && \
    apt-get install -qy wget && \
    apt-get install -qy curl && \
# Cleanup old packages
    apt-get -qy autoremove && \
# Add user jenkins to the image
    useradd  -m jenkins  && \
# Set password for the jenkins user (you may want to alter this).
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.ssh

#ADD settings.xml /home/jenkins/.m2/
# Copy authorized keys
#COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys

RUN  chown -R jenkins:jenkins /home/jenkins/.ssh/

# Standard SSH port
EXPOSE 22

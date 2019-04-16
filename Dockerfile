# Development environment image.
FROM ubuntu:18.04

# Base
# ----
RUN apt-get update && \
    apt-get install -y \
        curl \
        unzip \
        lsb-release \
        software-properties-common \
        jq \
        make \
        ssh \
        tmux \
        vim \
        sudo \
        gettext-base \
        gnupg2 \
        python3-pip \
        git 

RUN ln /usr/bin/pip3 /usr/bin/pip && \
    ln /usr/bin/python3 /usr/bin/python

# Node
# ----
ARG NODEJS_VERSION=node_11.x

RUN export DISTRO="$(lsb_release -s -c)" && \
    curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://deb.nodesource.com/${NODEJS_VERSION} $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list && \
    echo "deb-src https://deb.nodesource.com/${NODEJS_VERSION} $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs

# Terraform
# ---------
ARG TERRAFORM_VERSION=0.11.11

RUN curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/bin/terraform

# GCP
# ---
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && \
    apt-get install google-cloud-sdk -y

# Docker
# ------
ARG DOCKER_VERSION=18.09.5
ARG DOCKER_GROUP_PID=999
ARG DOCKER_COMPOSE_VERSION=1.24.0

RUN curl https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz > /tmp/docker.tgz && \
    tar xzf /tmp/docker.tgz -C /tmp && \
    cp /tmp/docker/docker /usr/bin/docker && \
    rm -r /tmp/docker*

RUN curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose && \
    chmod +x /usr/bin/docker-compose

RUN groupadd -g ${DOCKER_GROUP_PID} docker

# User
# ----
ARG USER=charlie
ARG PASSWORD=pass

RUN groupadd -g 1000 ${USER} && \
    useradd -g 1000 -m ${USER} && \
    usermod -aG sudo,docker ${USER} && \
    echo ${USER}:${PASSWORD} | chpasswd

# Init scripts
# ------------
ADD ./scripts/dev-shell-init.sh /etc/init.d/
RUN chmod +x /etc/init.d/dev-shell-init.sh

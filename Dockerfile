ARG FROM_IMAGE=nvidia/cuda
ARG CUDA_VERSION=10.0
ARG CUDA_SHORT_VERSION=${CUDA_VERSION}
ARG LINUX_VERSION=ubuntu16.04
FROM ${FROM_IMAGE}:${CUDA_VERSION}-devel-${LINUX_VERSION}

ARG JVM_JVMCI_URL=https://github.com/graalvm/openjdk8-jvmci-builder/releases/download/jvmci-19.3-b02/openjdk-8u222-jvmci-19.3-b02-linux-amd64.tar.gz
ARG JVM_JVMCI=openjdk1.8.0_222-jvmci-19.3-b02
ARG MX_GIT_URL=https://github.com/graalvm/mx.git
ARG TINI_VERSION=v0.18.0

# Set environment
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/lib
ENV PATH=${PATH}:/usr/local/cuda/bin:/${JVM_JVMCI}/bin:/mx
ENV JAVA_HOME=/${JVM_JVMCI}


RUN apt-get update -y --fix-missing && \
  apt-get upgrade -y && \
  apt-get -qq install apt-utils -y --no-install-recommends && \
  apt-get install -y \
    curl \
    git \
    python \
    python3 \
    wget \
  && rm -rf /var/lib/apt/lists/*

RUN cd / && \
  git clone ${MX_GIT_URL}

RUN wget ${JVM_JVMCI_URL} -O jvmci.tgz && \
  tar xfz jvmci.tgz -C / && \
  rm jvmci.tgz

RUN curl -L https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini -o /usr/bin/tini && \
      chmod +x /usr/bin/tini

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]

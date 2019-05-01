# Build Kubectl Container
ARG IMAGE_USER=geoffh1977
ARG IMAGE_NAME=alpine
ARG IMAGE_VERSION=latest

FROM ${IMAGE_USER}/${IMAGE_NAME}:${IMAGE_VERSION}
LABEL maintainer="geoffh1977 <geoffh1977@gmail.com>"
USER root

ARG KUBERNETES_VERSION=1.13.0

# Install kubectl
# hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates && \
  wget -q -O /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl" && \
  mkdir -p /config /project && \
  chmod 0755 /usr/bin/kubectl && \
  chown "${ALPINE_USER}":"${ALPINE_USER}" /config /project

ENV HOME=/config

VOLUME ["/project"]
USER ${ALPINE_USER}
WORKDIR /project
CMD ["/usr/bin/kubectl"]

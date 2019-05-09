# Build Kubectl Container
FROM geoffh1977/alpine:latest
LABEL maintainer="geoffh1977 <geoffh1977@gmail.com>"
USER root

# Install kubectl
# hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates && \
  wget -q -O /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/v1.14.1/bin/linux/amd64/kubectl" && \
  mkdir -p /config /project && \
  chmod 0755 /usr/bin/kubectl && \
  chown "${ALPINE_USER}":"${ALPINE_USER}" /config /project

ENV HOME=/config

VOLUME ["/project"]
USER ${ALPINE_USER}
WORKDIR /project
CMD ["/usr/bin/kubectl"]

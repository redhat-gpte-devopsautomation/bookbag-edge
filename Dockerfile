FROM quay.io/openshifthomeroom/workshop-dashboard:5.0.0

USER root

COPY . /tmp/src

ARG OC_VERSION=4.12
ARG OC_URL=https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-${OC_VERSION}/openshift-client-linux.tar.gz
ARG BIN_PATH=/opt/workshop/bin
  
RUN curl "${OC_URL}" -sL | tar zx -C ${BIN_PATH}/ oc kubectl

RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src

USER 1001

RUN /usr/libexec/s2i/assemble

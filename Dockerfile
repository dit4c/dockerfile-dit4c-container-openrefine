FROM dit4c/dit4c-container-base:latest
MAINTAINER Tim Dettrick <t.dettrick@uq.edu.au>

RUN fsudo yum install -y jre

RUN OPENREFINE_VERSION=2.6-rc1 && \
  curl -s -L "https://github.com/OpenRefine/OpenRefine/releases/download/v${OPENREFINE_VERSION}/openrefine-linux-${OPENREFINE_VERSION}.tar.gz" | \
    tar xzv -C /opt && \
  ln -s /opt/openrefine-${OPENREFINE_VERSION} /opt/openrefine

# Add supporting files (directory at a time to improve build speed)
COPY etc /etc
COPY var /var

# Because COPY doesn't respect USER...
USER root
RUN chown -R researcher:researcher /etc /opt /var
USER researcher

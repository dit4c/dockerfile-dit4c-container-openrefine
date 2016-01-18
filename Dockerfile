FROM dit4c/dit4c-container-base
MAINTAINER Tim Dettrick <t.dettrick@uq.edu.au>

RUN yum install -y jre

RUN OPENREFINE_VERSION=2.6-rc.2 && \
  curl -s -L "https://github.com/OpenRefine/OpenRefine/releases/download/${OPENREFINE_VERSION}/openrefine-linux-${OPENREFINE_VERSION}.tar.gz" | \
    tar xzv -C /opt && \
  ln -s /opt/openrefine-${OPENREFINE_VERSION} /opt/openrefine
# Add supporting files (directory at a time to improve build speed)
COPY etc /etc
COPY var /var

RUN chown -R researcher:researcher /home/researcher

# Initialize run environment
RUN su - researcher -c 'JAVA_OPTIONS="-Drefine.headless=true" timeout 20s /opt/openrefine/refine -i 127.0.0.1' || true

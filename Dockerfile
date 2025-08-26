FROM ubuntu:22.04
MAINTAINER bennett waxse (bennett.waxse@nih.gov)
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/Linux-metal.tar.gz \
    http://csg.sph.umich.edu/abecasis/metal/download/Linux-metal.tar.gz && \
    cd /tmp && \
    tar -xzf Linux-metal.tar.gz && \
    cp metal /usr/local/bin/ && \
    chmod +x /usr/local/bin/metal && \
    rm -rf /tmp/*

# Default command
CMD ["metal"]

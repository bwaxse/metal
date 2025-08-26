# Minimal Dockerfile for METAL meta-analysis
FROM ubuntu:22.04
MAINTAINER bennett waxse (bennett.waxse@nih.gov)
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN curl -L -o generic-metal-2011-03-25.tar.gz \
    http://csg.sph.umich.edu/abecasis/Metal/download/generic-metal-2011-03-25.tar.gz

# Extract and install the pre-compiled binary
RUN tar -xzf generic-metal-2011-03-25.tar.gz && \
    cd generic-metal && \
    cp executables/metal /usr/local/bin/ && \
    chmod +x /usr/local/bin/metal

WORKDIR /
CMD ["metal"]

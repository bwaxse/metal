FROM ubuntu:22.04
MAINTAINER bennett waxse (bennett.waxse@nih.gov)
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L http://csg.sph.umich.edu/abecasis/metal/download/Linux-metal.tar.gz | \
    tar -xzC /tmp && \
    cp /tmp/metal /usr/local/bin/ && \
    chmod +x /usr/local/bin/metal

# Default command
CMD ["metal"]

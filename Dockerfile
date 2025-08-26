# Minimal Dockerfile for METAL meta-analysis
FROM ubuntu:24.04 
MAINTAINER bennett waxse (bennett.waxse@nih.gov)
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Download pre-compiled binary if available
RUN wget -O /usr/local/bin/metal http://csg.sph.umich.edu/abecasis/metal/download/Linux-metal.tar.gz || \
    echo "Pre-compiled binary not available"

RUN chmod +x /usr/local/bin/metal

# Default command
CMD ["metal"]

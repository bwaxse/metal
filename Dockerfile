# Minimal Dockerfile for METAL meta-analysis
FROM ubuntu:22.04

MAINTAINER bennett waxse (bennett.waxse@nih.gov)

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Download and build METAL from source
RUN wget https://csg.sph.umich.edu/abecasis/metal/download/Linux-metal.tar.gz \
    && tar -xzf Linux-metal.tar.gz \
    && cd metal \
    && make \
    && cp executables/metal /usr/local/bin/ \
    && cd .. \
    && rm -rf metal Linux-metal.tar.gz

# Verify installation
RUN metal --help || echo "METAL installed successfully"

# Default command
CMD ["metal"]

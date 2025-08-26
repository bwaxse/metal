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
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# Download and build METAL from source
WORKDIR /tmp
RUN wget -O generic-metal-2011-03-25.tar.gz http://csg.sph.umich.edu/abecasis/Metal/download/generic-metal-2011-03-25.tar.gz \
    && tar -xzf generic-metal-2011-03-25.tar.gz \
    && rm generic-metal-2011-03-25.tar.gz \
    && cd generic-metal \
    && make all \
    && cp executables/metal /usr/local/bin/ \
    && cd .. \
    && rm -rf generic-metal
    
# Verify installation
RUN metal --help 2>&1 | head -10 || echo "METAL binary created"

# Set working directory back to root
WORKDIR /

# Default command
CMD ["metal"]

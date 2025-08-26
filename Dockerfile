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
WORKDIR /tmp
RUN wget -v -O generic-metal-2011-03-25.tar.gz http://csg.sph.umich.edu/abecasis/Metal/download/generic-metal-2011-03-25.tar.gz

RUN tar -xzf generic-metal-2011-03-25.tar.gz && ls -la

# Build step by step with error checking
RUN cd generic-metal && ls -la
RUN cd generic-metal && cat Makefile || echo "No Makefile found"
RUN cd generic-metal && make all
RUN cd generic-metal && ls -la executables/
RUN cd generic-metal && cp executables/metal /usr/local/bin/

# Cleanup
RUN rm -rf /tmp/*

# Verify installation
RUN metal --help 2>&1 | head -10 || echo "METAL binary created"

# Set working directory back to root
WORKDIR /

# Default command
CMD ["metal"]

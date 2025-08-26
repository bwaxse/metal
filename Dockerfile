# Minimal Dockerfile for METAL meta-analysis
FROM ubuntu:22.04
MAINTAINER bennett waxse (bennett.waxse@nih.gov)

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Download pre-compiled binary if available
RUN wget -O /usr/local/bin/metal http://csg.sph.umich.edu/abecasis/metal/download/Linux-metal.tar.gz || \
    echo "Pre-compiled binary not available"

RUN chmod +x /usr/local/bin/metal

# Default command
CMD ["metal"]

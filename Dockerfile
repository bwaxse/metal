FROM ubuntu:22.04
MAINTAINER bennett waxse (bennett.waxse@nih.gov)
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/Linux-metal.tar.gz \
    http://csg.sph.umich.edu/abecasis/metal/download/Linux-metal.tar.gz

RUN cd /tmp && tar -tzf Linux-metal.tar.gz

RUN cd /tmp && tar -xzf Linux-metal.tar.gz && ls -la

RUN find /tmp -name "metal" -type f

# Default command
CMD ["echo", "Debug complete - check logs above"]

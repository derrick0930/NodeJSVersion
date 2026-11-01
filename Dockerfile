ARG NODE_VERSION=20
ARG DEBIAN=bookworm
FROM node:${NODE_VERSION}-${DEBIAN}-slim

RUN if grep -q 'VERSION_CODENAME=bullseye' /etc/os-release && [ -f /etc/apt/sources.list ]; then \
      sed -i -e 's|deb.debian.org/debian-security|archive.debian.org/debian-security|g' \
             -e 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' \
             -e 's|deb.debian.org/debian|archive.debian.org/debian|g' \
             -e '/bullseye-updates/d' /etc/apt/sources.list; \
      echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99archive; \
    fi

RUN apt-get update \
 && apt-get install -y --no-install-recommends git curl ca-certificates iproute2 build-essential python3 \
 && rm -rf /var/lib/apt/lists/* \
 && useradd -m -d /home/container -s /bin/bash container

COPY entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r$//' /entrypoint.sh && chmod +x /entrypoint.sh

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

CMD ["/bin/bash", "/entrypoint.sh"]

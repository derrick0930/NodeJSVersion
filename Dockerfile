ARG NODE_VERSION=20
ARG DEBIAN=bookworm
FROM node:${NODE_VERSION}-${DEBIAN}-slim

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

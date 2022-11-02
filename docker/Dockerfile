FROM ubuntu:22.04

# Update Ubuntu
RUN set -eux; apt-get update -y \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/list* /tmp/* /var/tmp/*

# Install docker in the docker image
RUN set -eux; apt-get update -y \
    && BUILD_DEPS='curl gnupg apt-transport-https ca-certificates' \
    && apt-get install -y $BUILD_DEPS --no-install-recommends \
    && curl -fsSL https://get.docker.com | sh - \
    && apt-get purge -y --auto-remove $BUILD_DEPS \
    && apt-get purge -y --auto-remove docker-ce-rootless-extras docker-scan-plugin docker-ce \
    && rm -rf /usr/libexec/docker/ \
    && rm /etc/apt/sources.list.d/docker.list \
    && rm -rf /var/lib/apt/list* /tmp/* /var/tmp/*

# Setup sudo for users
RUN set -eux; apt-get update -y \
    && apt-get install -y sudo --no-install-recommends \
    && echo 'Defaults lecture = never' >> /etc/sudoers \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/list* /tmp/* /var/tmp/*

# Vivado dependency
RUN set -eux; apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y locales libtinfo5 libx11-dev libxrender1 libxtst6 libxi6 libfreetype6 libfontconfig1 --no-install-recommends \
    && locale-gen "en_US.UTF-8" \
    && rm -rf /var/lib/apt/list* /tmp/* /var/tmp/*

# Bitter applications dependencies
RUN set -eux; apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y python3 pip git \
    && python3 -m pip install click \
    && locale-gen "en_US.UTF-8" \
    && rm -rf /var/lib/apt/list* /tmp/* /var/tmp/*

# Install tool to run as user within docker
RUN set -eux; apt-get update -y \
    && apt-get install -y gosu \
    && gosu nobody true \
    && rm -rf /var/lib/apt/list* /tmp/* /var/tmp/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

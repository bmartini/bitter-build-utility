#!/bin/bash

# Add local user, either use the HOST_USER_ID if passed in at runtime or fallback
USER_ID=${HOST_USER_ID:-9001}

useradd --shell /bin/bash --uid $USER_ID --non-unique --create-home user \
    --groups sudo,docker

exec /usr/sbin/gosu user "$@"

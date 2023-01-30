#!/bin/bash

# https://stackoverflow.com/a/24112741/4490927
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# TOOD(kacper): change to detached mode
# -d detached mode
# docker run -d --restart unless-stopped \
docker run --restart unless-stopped \
  -v "$(pwd)/data":/data \
  -p 127.0.0.1:8080:8080 \
  maptiler/tileserver-gl:v4.4.3 -p 8080

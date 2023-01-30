#!/bin/bash

# https://stackoverflow.com/a/24112741/4490927
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

docker stop $(docker ps -q --filter ancestor=maptiler/tileserver-gl)
bash ./run_tileserver.sh

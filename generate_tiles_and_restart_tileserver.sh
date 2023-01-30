#!/bin/bash

# https://stackoverflow.com/a/24112741/4490927
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# pull latest changes
git pull

rm -rf tmp
mkdir tmp

echo "-------------------------------------------------------------------------"
echo "Starting generating Poland mbtiles"
echo $(date +'%Y-%m-%d %H:%M %Z')
echo "-------------------------------------------------------------------------"
bash ./_generate_tiles.sh

echo "-------------------------------------------------------------------------"
echo "Removing old mbtiles and moving new ones"
echo "-------------------------------------------------------------------------"
rm -rf data/output.mbtiles
mv tmp/output.mbtiles data

echo "-------------------------------------------------------------------------"
echo "Restarting tileserver"
echo "-------------------------------------------------------------------------"
bash ./_restart_tileserver.sh

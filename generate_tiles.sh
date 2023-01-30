#!/bin/bash

# https://stackoverflow.com/a/24112741/4490927
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# Generate mbtiles using Planetiler
#
# Planetiler options
# --nodemap-storage=mmap - requires 0.5x of the xxx.osm.pbf input size
# --nodemap-storage=ram - requires 1.5x of the xxx.osm.pbf input size
# -Xmx10g controls how much RAM to give the JVM (recommended: 0.5x the input .osm.pbf file size to leave room for memory-mapped files)
# --osm-parse-node-bounds=true (parse bounds from OSM nodes instead of header)

docker run -e \
  JAVA_TOOL_OPTIONS="-Xms6g -Xmx6g -XX:OnOutOfMemoryError=\"kill -9 %p\"" \
  -v "$(pwd)/tmp":/data \
  openmaptiles/planetiler-openmaptiles:3.14.0 \
  --area=poland \
  --bounds="13.9, 48.76, 24.6, 55.09" \
  --download  \
  --nodemap-type=sparsearray \
  --nodemap-storage=mmap \
  --force 2>&1 | tee -a logs.txt

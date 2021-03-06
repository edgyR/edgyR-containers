#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="edgyr"

for repo in \
  internal-ubuntu-builder \
  edgyr
do
  pushd $repo; ../build.sh ; popd
done

docker images

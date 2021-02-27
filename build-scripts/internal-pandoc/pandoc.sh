#! /bin/bash

set -e

if [ `ram_kilobytes.sh` -lt 7000000 ]
then
  export JOBS=1
else
  export JOBS=`nproc`
fi
echo "JOBS = $JOBS"

cabal --version
cabal update

cabal install \
  --flags="embed_data_files https" \
  --jobs=$JOBS \
  --overwrite-policy=always \
pandoc-$PANDOC_VERSION
ldd /usr/local/bin/pandoc

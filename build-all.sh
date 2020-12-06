#! /bin/bash

set -e

grep -i -e "BogoMIPS" /proc/cpuinfo
grep -i -e "MemTotal" /proc/meminfo
sudo cp two /proc/sys/vm/overcommit_memory
cat /proc/sys/vm/overcommit_memory
for i in \
  internal-build-dependencies \
  internal-ghc-8.2 \
  internal-cabal-3.0 \
  internal-pandoc \
  internal-r \
  internal-rstudio-server \
  edgyr 
do
  pushd $i
  ../build.sh
  popd
done

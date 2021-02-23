#! /bin/bash

set -e

echo "Installing Linux packages"
sudo apt-get install -qqy --no-install-recommends \
  flac \
  libfftw3-dev \
  libgdal-dev \
  libsox-fmt-all \
  libudunits2-dev \
  mp3splt \
  vlc \
  >> $EDGYR_LOGS/audio.log
echo "Installing R packages"
echo "This takes about 19 minutes on a 4 GB Nano"
echo "and 9 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('~/Installers/R/audio.R')" \
  >> $EDGYR_LOGS/audio.log
gzip -9 $EDGYR_LOGS/audio.log
#! /bin/bash

# Copyright (C) 2021 M. Edward (Ed) Borasky <mailto:znmeb@algocompsynth.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e
rm -fr $EDGYR_LOGS/authoring.log

echo "Installing Linux packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update > $EDGYR_LOGS/authoring.log 2>&1
sudo apt-get upgrade -y >> $EDGYR_LOGS/authoring.log 2>&1
sudo apt-get install -qqy --no-install-recommends \
  libpng-dev \
  >> $EDGYR_LOGS/authoring.log 2>&1
echo "Installing R packages"
echo "This takes about 25 minutes on a 4 GB Nano"
echo "and 12 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('~/Installers/R/authoring.R')" \
  >> $EDGYR_LOGS/authoring.log 2>&1

echo "Finished"

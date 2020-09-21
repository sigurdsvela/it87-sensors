#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
cd $DIR

sudo apt install lm-sensors -y &> /dev/null
sudo apt install inxi -y &> /dev/null

# Copy Sensor Config 
for f in ./sensors.d/*; do sudo ln -s "`pwd`/$f" /etc/sensors.d/; done

# Add kernal parameter to allow loading the it87 modules
kernelstub -a "acpi_enforce_resources=lax"

# Modprobe
sudo modprobe it87 force_id="0x8620"
sudo sensors-detect --auto
sudo ln -s "${DIR}/probe.it87.conf" /etc/modprobe.d/it87.conf
sudo ln -s "${DIR}/load.it87.conf" /etc/modules-load.d/it87.conf

cd -


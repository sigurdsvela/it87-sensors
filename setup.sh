sudo apt install lm-sensors -y
sudo apt install inxi -y

cd $(dirname $0)

# Copy Sensor Config 
for f in ./sensors.d/*; do sudo ln -s "`pwd`/$f" /etc/sensors.d/; done

# Add kernal parameter to allow loading the it87 modules
kernelstub -a "acpi_enforce_resources=lax"

# Modprobe
sudo modprobe it87 force_id="0x8620"
sensors-detect --auto
sudo ln -s "`dirname $0`/probe.it87.conf" /etc/modprobe.d/it87.conf
sudo ln -s "`dirname $0`/load.it87.conf" /etc/modules-load.d/it87.conf

cd -


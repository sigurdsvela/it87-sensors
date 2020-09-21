

# Setup it87 module, and force is
modprobe it87 force_id 0x8686
# Same as above, during boot
sudo printf "it87" > /etc/modules-load.d/it87.conf
sudo printf "options it87 force_id=0x8686" > /etc/modprobe.d/it87.conf

#!/system/bin/sh
# 
# Authored By samno For Jeckll & Hyde Kernel

# Remount All Partitions With noatime
for k in $(mount | grep relatime | cut -d " " -f3);
do
mount -o remount,noatime,nodiratime,noauto_da_alloc,barrier=0 $k
done;

# Set IO Scheduler At Boot
 echo "sio" > /sys/block/mmcblk0/queue/scheduler

# Switch CPUfreq To Hotplug
 echo "hotplug" >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# Post Boot Init.d Support
mount -o remount,rw /system
if [ -d /system/etc/init.d ]
then
chmod 755 /system/etc/init.d
else
mkdir /system/etc/init.d
chmod 755 /system/etc/init.d
fi

if [ -d /system/etc/init.d ]; then
  /sbin/busybox run-parts /system/etc/init.d
fi;

## End Of File ###

#!/bin/bash
read -p "ip server-> " ipserver
echo $ipserver
read -p "hostname->" hostname
echo $hostname
#-----------------------------------------------------------------------
# Khai bao repos cho Collectd 5.5
add-apt-repository -y ppa:rullmann/collectd

apt-get update 
## apt-get -y dist-upgrade && apt-get upgrade -y
echo "---------install git-----------------------"
apt-get install git -y
sleep 3
#-------------------------------------------------
echo "-----install collectd-client------------"
apt-get install collectd libjson-perl -y
echo "------Configure collectd -client--------"
filecollectd=/etc/collectd/collectd.conf
#-------------------------------------------------------
test -f $filecollectd.bka || cp $filecollectd $filecollectd.bka
#-------------------------------------------------------- 
rm $filecollectd
#-----------------Tao file moi rong-----------------------------------------
touch $filecollectd
#---------------------------------------------------------------------------
cat << EOF >>  $filecollectd
Hostname $hostname
FQDNLookup true
Interval 10
ReadThreads 5
LoadPlugin syslog
<Plugin syslog>
    LogLevel info
</Plugin>
#LoadPlugin battery
LoadPlugin cpu
LoadPlugin df
# LoadPlugin disk
# LoadPlugin entropy
LoadPlugin interface
# LoadPlugin irq
# LoadPlugin load
LoadPlugin memory
LoadPlugin network
LoadPlugin processes
# LoadPlugin swap
# LoadPlugin users

<Plugin interface>
  Interface "eth0"
  IgnoreSelected false
</Plugin>

<Plugin network>
    # client setup:
   Server "$ipserver" "2003"
</Plugin>

#Khai bao cac tuy chon plugin cho df
<Plugin df>
        # ignore rootfs; else, the root file-system would appear twice, causing
        # one of the updates to fail and spam the log
        FSType rootfs
        # ignore the usual virtual / temporary file-systems
        FSType sysfs
        FSType proc
        FSType devtmpfs
        FSType devpts
        FSType tmpfs
        FSType fusectl
        FSType cgroup
        IgnoreSelected true
</Plugin>

# Khai bao de hien thi RAM theo dang % thay vi dung luong
<Plugin memory>
        ValuesAbsolute false
        ValuesPercentage true
</Plugin>

# Khao bao hien thi CPU theo dang % va gop cac CPU neu nhu co nhieu CPU (CPU1, CPU2)
<Plugin cpu>
  ReportByCpu false
  ReportByState true
  ValuesPercentage true
</Plugin>


<Include "/etc/collectd/collectd.conf.d">
        Filter "*.conf"
</Include>
EOF
#------------------------------------------------------------------------
echo "Khoi dong lai collected"
sleep 3
service collectd restart
#-----------------------------------------------------------------------

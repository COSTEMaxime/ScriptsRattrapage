#!bin/bash

while getopts h:a:n:g:d: option
do
 case "${option}"
 in
 h) HOSTNAME=${OPTARG};;
 a) ADDRESS=${OPTARG};;
 n) NETMASK=${OPTARG};;
 g) GATEWAY=${OPTARG};;
 d) DNS=${OPTARG};;
 esac
done

IPCHECK='^(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))\.){3}0*(1?[0-9]{1,2}|2([??0-4][0-9]|5[0-5]))$'

#Argument check
if [ -z "$HOSTNAME" ]
 then
  echo "Wrong argument : hostname"
  exit 1
fi

if [[ ! "$ADDRESS" =~ $IPCHECK ]]
 then
  echo "Wrong argument : IP address"
  exit 1
fi

if [[ ! "$NETMASK" =~ $IPCHECK ]]
 then
  echo "Wrong argument : netmask"
  exit 1
fi

if [[ ! "$GATEWAY" =~ $IPCHECK ]]
 then
  echo "Wrong argument : gateway"
  exit 1
fi

if [[ ! "$DNS" =~ $IPCHECK ]]
 then
  echo "Wrong argument : DNS"
  exit 1
fi

#Hostname
HOSTNAMEFILE="/etc/hostname"
echo "$HOSTNAME" > $HOSTNAMEFILE

#IP configuration
NETWORKINGFILE="/etc/network/interfaces"
echo "
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
iface eth0 inet static
	address $ADDRESS
	netmask $NETMASK
	gateway $GATEWAY
	dns-nameservers $DNS" > $NETWORKINGFILE

shutdown -r now

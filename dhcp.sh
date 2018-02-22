#!bin/bash

echo "
subnet 192.168.0.0 netmask 255.255.255.0 {
  range 192.168.0.1 192.168.0.254;
  option domain-name-servers 192.168.0.250;
  option routers 192.168.0.2;
  option broadcast-address 192.168.0.255;
  default-lease-time 600;
  max-lease-time 7200;
}" > /etc/dhcp/dhcpd.conf
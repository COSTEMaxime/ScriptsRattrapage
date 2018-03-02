#!/bin/bash

LOG="error.log"

touch $LOG
sh install.sh &>> $LOG
sh setup.sh -h vm -a 192.168.1.100 -m 255.255.255.0 -g 192.168.1.2 -d 192.168.1.100 &>> $LOG
sh dhcp.sh &>> $LOG
sh addVHost.sh &>> $LOG
sh dns.sh &>> $LOG

echo "Felicitations !"

shutdown -r now
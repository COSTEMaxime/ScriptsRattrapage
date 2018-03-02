#!/bin/bash

echo '
zone "cesi.local" {
	type master;
	file "/etc/bind/db.test.local";
	forwarders{};
};

zone "1.168.192.in-addr.arpa" {
	type master;
	file "/etc/bind/db.1.168.192.in-addr.arpa";
	forwarders{};
};' > "/etc/bind/named.conf.local"

echo '
$TTL	604800
$ORIGIN	cesi.local.
@	IN	SOA	vm.cesi.local root.cesi.local. (
			15		; Serial
			604800		; Refresh
			86400		; Retry
			2419200		; Expire
			604800 )	; Negative Cache TTL
;
@	IN	NS	vm.cesi.local.
@	IN	A	192.168.1.100
@	IN	HINFO	"Info sur le serveur DNS" "Debian 8.6"
www	IN	A	192.168.1.100' > db.cesi.local

echo '
$TTL	604800
@	IN	SOA	vm.cesi.local. root.cesi.local. (
			17		; Serial
			604800		; Refresh
			86400		; Retry
			2419200		; Expire
			604800	)	; Negative Cache TTL
;
100	IN	PTR	cesi.local.' > db.1.168.192.in-addr.arpa

named-checkconf -z &>> error.log
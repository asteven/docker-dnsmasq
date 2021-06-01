#!/bin/sh

set -e

# Ping our gateways to workaround the 'silent host' problem in the
# DFA/DC network zone.
for gateway in $(ip route list 0/0 | awk '{print $3}'); do
   ping -q -c 3 "$gateway" >/dev/null
done

exec dnsmasq -k --conf-file=/etc/dnsmasq/dnsmasq.conf "$@"

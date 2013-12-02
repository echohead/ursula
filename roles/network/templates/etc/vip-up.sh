#!/bin/bash
set -eu

{% if undercloud_floating_ip is defined %}
# add undercloud floating ip
ifconfig eth0:float {{ undercloud_floating_ip }}
/usr/bin/arping -A -c 3 $(echo {{ undercloud_floating_ip }} | sed -r 's/\/[0-9]+//')
{% endif %}

{% if floating_ip is defined %}
# add overcloud floating ip
ifconfig br-ex:float {{ floating_ip }}
/usr/bin/arping -A -c 3 $(echo {{ floating_ip }} | sed -r 's/\/[0-9]+//')
{% endif %}

{% if neutron_gateway is defined %}
# add neutron gateway
ip addr add {{ neutron_gateway }} dev br-ex
/usr/bin/arping -A -c 3 $(echo {{ neutron_gateway }} | sed -r 's/\/[0-9]+//')
{% endif %}

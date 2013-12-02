#!/bin/bash
set -eu

{% if undercloud_floating_ip is defined %}
# remove undercloud floating ip
if ip addr show dev eth0 | grep {{ undercloud_floating_ip }}; then
  ip addr del {{ undercloud_floating_ip }} dev eth0
fi
{% endif %}

{% if floating_ip is defined %}
# remove overcloud floating ip
if ip addr show dev br-ex | grep {{ floating_ip }}; then
  ip addr del {{ floating_ip }} dev br-ex
fi
{% endif %}

{% if neutron_gateway is defined %}
# remove neutron gateway ip
if ip addr show dev br-ex | grep {{ neutron_gateway }}; then
  ip addr del {{ neutron_gateway }} dev br-ex
fi
{% endif %}

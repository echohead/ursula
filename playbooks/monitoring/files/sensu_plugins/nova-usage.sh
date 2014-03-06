#!/bin/bash
set -e

if [ "$#" -ne 1 ]; then
  echo "Usage: nova-usage.sh ENVIRONMENT_NAME"
  exit 1
fi

STACK_NAME="$1"
timestamp=$(date +%s)

source /root/stackrc

vcpus_total=$(nova hypervisor-stats | grep "vcpus " | awk '{print $4}')
vcpus_used=$(nova hypervisor-stats | grep "vcpus_used" | awk '{print $4}')
mem_mb_total=$(nova hypervisor-stats | grep "memory_mb " | awk '{print $4}')
mem_mb_used=$(nova hypervisor-stats | grep "memory_mb_used" | awk '{print $4}')
num_instances=$(nova hypervisor-stats | grep "running_vms" | awk '{print $4}')

echo -e "$STACK_NAME.vcpus_total\t$vcpus_total\t$timestamp"
echo -e "$STACK_NAME.vcpus_used\t$vcpus_used\t$timestamp"
echo -e "$STACK_NAME.mem_mb_total\t$mem_mb_total\t$timestamp"
echo -e "$STACK_NAME.mem_mb_used\t$mem_mb_used\t$timestamp"
echo -e "$STACK_NAME.num_instances\t$num_instances\t$timestamp"

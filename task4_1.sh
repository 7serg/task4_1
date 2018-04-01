#!/bin/bash
mothbm=$(dmidecode -s baseboard-manufacturer)
mothprod=$(dmidecode -s baseboard-product-name)
sysnum=$(dmidecode -s system-serial-number)

echo "---Hardware---
CPU:$(cat /proc/cpuinfo | awk -F: '/model name/ {print $2}')
RAM:$(free -hm | grep -i 'mem:' | awk '{print $2}')
Motherboard: ${mothbm:-unknown}/${mothprod:-unknown}
System Serial Number: ${sysnum:-unknown}
---System---
OS Distribution: $(cat /etc/*-release | awk -F= '{IGNORECASE = 1}; /distrib_description/ {print $2}' | sed 's/^"//;s/"$//')
Kernel version: $(uname -r)
Installation date: $(ls -ld --time-style=+%F /var/log/installer | awk '{print $6}')
Hostname: $(hostname)
Uptime: $(uptime -p | sed 's/^up //')
Processes running: $(ps -ef --no-headers | wc -l)
Users logged in: $(who | awk '{print $1}' | wc -l)
---Network---
$(ip -4 -o a | awk '{print $2": "$4}')
$(for i in $(ls -1 /sys/class/net); do ( ip -4 -o a | awk '{print $2}' | grep -q $i) || echo "$i: -"; done)" > $(dirname $(readlink -f $0))/task4_1.out

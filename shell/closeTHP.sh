#! /bin/bash
echo "******** CLOSE THP *********"
echo "if test -f /sys/kernel/mm/transparent_hugepage/enabled; then" >> /etc/rc.d/rc.local
echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" >> /etc/rc.d/rc.local
echo "fi" >> /etc/rc.d/rc.local
echo "if test -f /sys/kernel/mm/transparent_hugepage/defrag; then" >> /etc/rc.d/rc.local
echo "echo never > /sys/kernel/mm/transparent_hugepage/defrag" >> /etc/rc.d/rc.local
echo "fi" >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local
echo "******** END ********"

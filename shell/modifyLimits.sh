#! /bin/bash
echo "******** Modify system limits ********"
echo "* soft nofile 65535" >> /etc/security/limits.conf
echo "* hard nofile 65535" >> /etc/security/limits.conf
echo "$USER   - nofile 65535" >> /etc/security/limits.conf
echo "$USER   - nproc  65535" >> /etc/security/limits.conf
echo "******** END ********"

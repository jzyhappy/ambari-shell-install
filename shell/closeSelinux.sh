#! /bin/bash
echo "******** CLOSE SELINUX *********"
setenforce 0
file=/etc/selinux/config
sed -i "7s/^/#/" $file
sed '7 iSELINUX=disabled' -i $file
echo "******** END ********"

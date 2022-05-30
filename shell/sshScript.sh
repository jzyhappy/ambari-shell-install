#! /bin/bash
ssh-keygen -t rsa
# 改为集群所在网段（和hosts中配置对应）
ALL_CLIENTS=`cat /etc/hosts| grep "$VLAN" | awk '{print $2}'`
for client in $ALL_CLIENTS
do
        echo "=============copy-ssh-id $client============="
        ssh-copy-id $client
done

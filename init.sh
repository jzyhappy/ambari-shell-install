for i in {001..26};
do
#create user
scp /home/createUser.sh $HOSTSPEC$i:/home/;
ssh $HOSTSPEC$i sh /home/createUser.sh;
#set hosts
scp /etc/hosts $HOSTSPEC$i:/etc/;
#stop firewalld
systemctl disable firewalld
systemctl stop firewalld
#disable vm.swappiness
ssh $HOSTSPEC$i sysctl vm.swappiness=0;
ssh $HOSTSPEC$i echo vm.swappiness=0 >> /etc/sysctl.conf;
#close selinux and THP
scp /home/close* $HOSTSPEC$i:/home/;
ssh $HOSTSPEC$i sh /home/closeSelinux.sh;
ssh $HOSTSPEC$i sh /home/closeTHP.sh;
ssh $HOSTSPEC$i reboot;
#install jdk
scp ${path}jdk-8u201-linux-x64.tar.gz $HOSTSPEC$i:/home/ocdp/;
scp /home/installJDK.sh $HOSTSPEC$i:/home/;
ssh $HOSTSPEC$i mv /home/ocdp/jdk-8u201-linux-x64.tar.gz ${path};
ssh $HOSTSPEC$i sh /home/installJDK.sh;
ssh $HOSTSPEC$i source /etc/profile;
#modifyLimits
scp /home/modifyLimits.sh $HOSTSPEC$i:/home/;
ssh $HOSTSPEC$i sh /home/modifyLimits.sh;
#yum ambari.repo
scp /etc/yum.repos.d/ambari.repo $HOSTSPEC$i:/etc/yum.repos.d/;
ssh $HOSTSPEC$i yum clean all && yum makecache;
done

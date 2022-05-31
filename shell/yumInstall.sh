tar=ambari-2.5.0.3-centos7.tar.gz
HDP=HDP-2.6.5.0-centos7-rpm.tar.gz
UTILS=HDP-UTILS-1.1.0.21-centos7.tar.gz
PATH=/home
yum -y install httpd createrepo
systemctl enable httpd
systemctl restart httpd
chmod -R 755 /var/www/html/
cd /var/www/html/
cp $PATH/$tar /var/www/html
cp $PATH/HDP* /var/www/html
tar -zxvf $tar 
rm -rf $tar 
tar -zxvf $HDP 
rm -rf $HDP 
tar -zxvf $UTILS 
rm -rf $UTILS 
#set ambari.repo hdp.repo
cd /var/www/html/ambari/centos7/2.5.0.3/
createrepo --update ./
cd /var/www/html/HDP/centos7/2.6.5.0/
createrepo --update ./
yum clean all && yum makecache
# mysql connect
mkdir -p /usr/share/java/
cp /opt/mysql-connector-java-5.1.38.jar /usr/share/java/
mv /usr/share/java/mysql-connector-java-5.1.38.jar /usr/share/java/mysql-connector-java.jar

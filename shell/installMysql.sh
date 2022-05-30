#! /bin/bash
echo "******** INSTALL MYSQL *********"
#卸载原有的mariadb
OLD_MYSQL=`rpm -qa|grep mariadb`
profile=/etc/profile
for mariadb in $OLD_MYSQL
do
	rpm -e --nodeps $mariadb
done
#删除原有的my.cnf
rm -rf /etc/my.cnf
#添加用户组 用户
groupadd mysql
useradd -g mysql mysql

#解压mysql包并修改名称
tar -zxvf /opt/mysql-5.7.27-el7-x86_64.tar.gz -C /usr/local
mv /usr/local/mysql-5.7.27-el7-x86_64 /usr/local/mysql
#更改所属的组和用户
chown -R mysql /usr/local/mysql
chgrp -R mysql /usr/local/mysql

mkdir -p /usr/local/mysql/data
chown -R mysql:mysql /usr/local/mysql/data

#粘贴配置文件my.cnf 内容见八 中的 my.cnf
cp /opt/srcConfig/mysql/my.cnf /usr/local/mysql/

# 安装mysql
/usr/local/mysql/bin/mysql_install_db --user=mysql --basedir=/usr/local/mysql/ --datadir=/usr/local/mysql/data/

#设置文件及目录权限：
cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
chown 777 /usr/local/mysql/my.cnf
chmod +x /etc/init.d/mysqld

mkdir /var/lib/mysql
chmod 777  /var/lib/mysql

#启动mysql
/etc/init.d/mysqld start

#设置开机启动
chkconfig --level 35 mysqld on
chmod +x /etc/rc.d/init.d/mysqld
chkconfig --add mysqld

#修改环境变量 
#行数需根据实际情况修改
sed '78s/$/&:\/usr\/local\/mysql\/bin/' -i $profile
mysqlPw=`sed -n 2p /root/.mysql_secret`
mysqlPwTMP=`sed -n 2p /root/.mysql_secret`1
mysqlNewPw=123456
hostname=`"hostname"`
#ssh $hostname "source /etc/profile;java -version"
ssh $hostname "source /etc/profile;mysqladmin -h127.0.0.1 -uroot -p'$mysqlPw' password '$mysqlPwTMP';mysqladmin -h127.0.0.1 -uroot -p'$mysqlPwTMP' password '$mysqlNewPw';exit"


echo "******** MYSQL installation completed ********"

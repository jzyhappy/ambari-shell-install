# ambari-shell-install
One-click deployment of ambari using shell script
## 背景&目的
从2016年第一个ambari相关项目开始，需要频繁的部署，不同的ambari版本,使用shell实现一键式部署ambari，后期不断完善，实际上还不够完美。
## 准备
1. ambari-2.5.0.3-centos7.tar.gz
2. HDP-2.6.5.0-centos7-rpm.tar.gz
3. HDP-UTILS-1.1.0.21-centos7.tar.gz
4. mysql-5.7.27-el7-x86_64.tar.gz
5. mysql-connector-java-5.1.47.jar
6. jdk-8u201-linux-x64.tar.gz
jdk和mysql需要放在指定路径/opt
版本根据项目需求自己选择对应的版本，可在shell/yumInstall.sh、intsqllMysql.sh、installJDK.sh中替换对应的tar包
## 服务器准备
1. 操作系统：centos7
2. 网络配置已完成
3. 机房已配备ntp服务，集群使用ntpdate进行时钟同步
## 执行
```shell
sh init.sh
#install ambari
amabri-setup

#init ambari mysql
mysql -e"use mysql;GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION" -p123456 -h127.0.0.1
mysql -e"CREATE USER ambari IDENTIFIED BY '123456'" -p123456 -h127.0.0.1
mysql -e"CREATE DATABASE ambari" -p123456 -h127.0.0.1
# 执行ambari的sql脚本 路径默认是一样的
mysql  -uroot -p123456 -h127.0.0.1 ambari < /var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql
mysql -e"grant ALL on ambari.* to ambari;flush  privileges" -uroot -p123456 -h127.0.0.1

#start ambari
ambari-server start
```
## 注意
如果自行使用amabri-setup以下内容可以不管,在初始化mysql完成后
conf/ambari.properties 中配置需要使用sed 命令修改mysql，jdk相关内容。
```shell
cat conf/ambari.properties > /etc/ambari-server/conf/ambari.properties
#set amabri mysqlpassword
echo "123456" >  /etc/ambari-server/conf/password.dat
```
## 版本
当前版本为v0.1，未经过严格测试。

## 后续
### 期望&缺陷
1. 加入ntp的安装
2. for循环1到26，用该提出来作为配置
3. tar 应该使用配置文件管理起来
4. mysql部分和amabri setup应该融入脚本
实现从裸机直接到amabri页面安装的一键式脚本
### 验证脚本
目前脚本没有经过严格验证，需要使用者自行修改tar包，jdk，mysql等相关配置，验证脚本的准确性

## 文档

#! /bin/bash
echo "******** JDK ********"
#path=/opt/
userAndGroup=$USER:$USER
tar -xvf ${JDKPATH}jdk-8u201-linux-x64.tar.gz -C ${JDKPATH}
chown -R ${userAndGroup} ${JDKPATH}jdk1.8.0_201
ln -s ${JDKPATH}jdk1.8.0_201 ${JDKPATH}jdk
chown -R ${userAndGroup} ${JDKPATH}jdk
# 我这里是没有配置过环境变量的新机器，所以可以直接在/etc/profile 后追加
# 如果已经有环境变量可根据具体情况使用sed -i等命令配置
echo "export JAVA_HOME=${JDKPATH}jdk" >> /etc/profile
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile
echo "export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >> /etc/profile
rm -rf /usr/bin/java
rm -rf /usr/bin/javac
#hostname=`"hostname"`
#ssh $hostname "source /etc/profile;java -version;exit"
source /etc/profile
echo "******* JDK installation completed ********"

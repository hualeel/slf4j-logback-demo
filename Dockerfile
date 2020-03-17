FROM centos:7
RUN echo "ip_resolve=4" >> /etc/yum.conf
RUN yum update -y && yum install -y java-1.8.0-openjdk

# 设置时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
ENV workdir /app/

# 拷贝jar
ENV jarfile_name tsf-spring-cloud-consumer-0.0.1-SNAPSHOT.jar
ENV jar target/tsf-spring-cloud-consumer-0.0.1-SNAPSHOT.jar
COPY ${jar} ${workdir}
WORKDIR ${workdir}

# tsf-consul-template-docker 用于文件配置功能
ADD tsf-consul-template-docker.tar.gz /root/

#----没有日志--------
# JAVA_OPTS 环境变量的值为部署组的 JVM 启动参数，在运行时 bash 替换。使用 exec 以使 Java 程序可以接收 SIGTERM 信号。
JAVA_OPTS=-Xms128m -Xmx512m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m


# 如果不需要使用文件配置功能，改用下面的启动命令
# CMD ["sh", "-ec", "exec java ${JAVA_OPTS} -jar ${jar}"]

#-------对于私有化的 TSF ，如果1.13 版本之前的版本要支持 stdout 日志，需要在启动命令中将 stdout 及 stderr 重定向到一个文件中
RUN mkdir -p /data/tsf_std/stdout/logs
RUN mkdir -p /data/tsf_logs
CMD ["exec java ${JAVA_OPTS} -jar ${jarfile_name} 2>&1 > /data/tsf_std/stdout/logs/sys_log.log"]

FROM centos:7
RUN echo "ip_resolve=4" >> /etc/yum.conf
RUN yum update -y && yum install -y java-1.8.0-openjdk

# 设置时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
ENV workdir /app/

# 拷贝jar
ENV jarfile_name slf4j-logback-demo-0.0.1-SNAPSHOT.jar
ENV jar target/slf4j-logback-demo-0.0.1-SNAPSHOT.jar
COPY ${jar} ${workdir}
WORKDIR ${workdir}

# JAVA_OPTS 环境变量的值为部署组的 JVM 启动参数，在运行时 bash 替换。使用 exec 以使 Java 程序可以接收 SIGTERM 信号。
ENV JAVA_OPTS -Xms128m -Xmx512m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m

RUN mkdir -p /data/tsf_logs
CMD ["sh", "-ec", "exec java ${JAVA_OPTS} -jar ${jarfile_name}"]

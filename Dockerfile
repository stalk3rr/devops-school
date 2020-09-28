FROM ubuntu:18.04
RUN /bin/bash
RUN apt-get update && apt-get install -y git maven openjdk-8-jdk wget apt-utils
#download and install tomcat
RUN mkdir /usr/local/tomcat
RUN wget https://apache-mirror.rbc.ru/pub/apache/tomcat/tomcat-8/v8.5.58/bin/apache-tomcat-8.5.58.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.58/* /usr/local/tomcat/
#download and unpack my boxfuse example
RUN mkdir /usr/local/boxfuse
WORKDIR /usr/local/boxfuse
RUN git clone https://github.com/stalk3rr/boxfuse-sample-java-war-hello.git
WORKDIR /usr/local/boxfuse/boxfuse-sample-java-war-hello
#build boxfuse artifact
RUN mvn package
RUN cp -rf target/hello.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh","run"]
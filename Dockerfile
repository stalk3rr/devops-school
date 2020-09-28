FROM cloudunit/tomcat-85
RUN apt-get update \
    apt-get upgrade \
    apt-get install git maven openjdk-8-jdk
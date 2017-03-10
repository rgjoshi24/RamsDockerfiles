FROM ubuntu:saucy
# Update Ubuntu
RUN apt-get update && apt-get -y upgrade
# Add oracle java 7 repository
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update
# Accept the Oracle Java license
RUN echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
# Install Oracle Java
RUN apt-get -y install oracle-java7-installer
# Install tomcat
RUN apt-get -y install tomcat7
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/default/tomcat7
EXPOSE 9080
# Download Slashdot homepage
RUN mkdir /var/lib/tomcat7/webapps/slashdot
RUN mkdir /var/lib/tomcat7/webapps/sample
RUN wget http://www.slashdot.org -P /var/lib/tomcat7/webapps/slashdot
# Start Tomcat, after starting Tomcat the container will stop. So use a 'trick' to keep it running.
ADD c/NANNA_FOLDER_US/ONS_KSADevOps/Docker/Samplewar/Samplewarsample.war /usr/local/tomcat/webapps/sample
CMD service tomcat7 start && tail -f /var/lib/tomcat7/logs/catalina.out
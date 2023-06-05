FROM tomcat:8.5.89-jdk17-temurin-focal
COPY target/onlinebookstore.war /usr/local/tomcat/webapps

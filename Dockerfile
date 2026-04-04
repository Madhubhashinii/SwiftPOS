FROM tomcat:11.0-jdk23

RUN rm -rf /usr/local/tomcat/webapps/*

COPY SwiftPOS.war /usr/local/tomcat/webapps/SwiftPOS.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

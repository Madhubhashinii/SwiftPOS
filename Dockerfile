FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY SwiftPOS.war /usr/local/tomcat/webapps/SwiftPOS.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

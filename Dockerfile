FROM praveenmenon/swe-645:version01
LABEL maintainer="pamenon9@gmail.com"

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

ADD student-service.war $CATALINA_HOME/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]
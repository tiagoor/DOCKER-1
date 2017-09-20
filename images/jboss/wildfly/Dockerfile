FROM jboss/wildfly

EXPOSE 9990
EXPOSE 8080

ADD commands.cli /tmp
ADD entrypoint.sh /tmp
USER root 
RUN chown -R jboss:jboss /tmp
RUN chmod +x /tmp/entrypoint.sh 

USER jboss

WORKDIR /tmp
ENTRYPOINT ["/tmp/entrypoint.sh"]



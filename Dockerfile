FROM tomcat:9-jre8-slim

# Install Geo::BUFR
RUN apt-get update; \
    apt-get install -y gcc make cpanminus && \
    cpanm Geo::BUFR && \
    apt-get remove --purge -y gcc make curl cpanminus \
    && apt-get clean

# Remove packages and setup env
RUN rm -rf /var/lib/apt/lists/* && \
    ln -s /bin/sed /usr/bin/sed	&& \
    mkdir -p /usr/local/tables/BT-29 && \
    mkdir -p /usr/local/bufr

# Copy local content
COPY tables/BT-29 /usr/local/tables/BT-29
COPY dist/*.war /usr/local/tomcat/webapps/
COPY src/index.html /usr/local/tomcat/webapps/ROOT

# Tune tomcat start
RUN rm -rf /usr/local/tomcat/webapps/docs && \
    rm /usr/local/tomcat/lib/websocket-api.jar && \
    rm /usr/local/tomcat/lib/tomcat-websocket.jar && \
    echo "org.apache.catalina.startup.ContextConfig.jarsToSkip=*.jar" >> /usr/local/tomcat/conf/catalina.properties && \
    echo "tomcat.util.scan.StandardJarScanFilter.jarsToSkip=a*.jar,b*.jar,c*.jar,e*.jar,f*.jar,l*.jar,g*.jar,h*.jar,j*.jar,tomcat*.jar,s*.jar,taglibs-standard-spec*.jar" >> /usr/local/tomcat/conf/catalina.properties && \
    chmod -R 777 /usr/local/tomcat && \
    chmod  777 /usr/local/bufr

# Setup env in docker container to run the decoders
ENV BUFR_TABLES /usr/local/tables/BT-29/
ENV PATH="/usr/local/tomcat/webapps/bufrdc/WEB-INF/resource/bin:/usr/local/tomcat/webapps/libecBufrX/WEB-INF/resource/bin:${PATH}"
ENV LD_LIBRARY_PATH /usr/local/tomcat/webapps/libecBufrX/WEB-INF/resource/bin/.libs


### Containers should NOT run as root as a good practice
USER 10001

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]





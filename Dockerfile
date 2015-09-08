FROM debian:jessie 
RUN apt-get update && apt-get install -y wget zip openjdk-7-jre-headless 
RUN echo "deb http://pub-repo.sematext.com/debian sematext main" >> /etc/apt/sources.list
RUN wget -O - https://pub-repo.sematext.com/debian/sematext.gpg.key |  apt-key add -
RUN apt-get update
RUN apt-get install --force-yes -y spm-client
RUN apt-get autoremove && apt-get autoclean
ADD ./run.sh run.sh
ADD ./netmap.sh /opt/spm/bin/netmap.sh
RUN chmod +x run.sh
RUN chmod +x /opt/spm/bin/netmap.sh
RUN chmod +x /opt/spm/bin/spm-client-setup-conf.sh
RUN ln /usr/bin/env /bin/env
ENV PATH ${PATH}:/opt/spm/bin/
VOLUME /opt/spm
CMD ["/run.sh"]
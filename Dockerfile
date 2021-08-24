FROM registry.access.redhat.com/ubi8/ubi:8.0
ENV DOCROOT=/var/www/html
RUN yum -y install httpd --nodocs && yum clean all -y &&  \
    echo "IT WORKS" > ${DOCROOT}/index.html
ONBUILD COPY src/ ${DOCROOT}/
EXPOSE 8080
LABEL io.k8s.description="A basic Apache HTTP Server child image, uses ONBUILD" \
      io.k8s.display-name="Apache HTTP Server" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="apache, httpd"
RUN sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf
RUN chgrp -R 0 /var/log/httpd /var/run/httpd && \
    chmod -R g=u /var/log/httpd /var/run/httpd
RUN rm -rf /run/httpd && mkdir /run/httpd
USER 1001
CMD /usr/sbin/httpd -DFOREGROUND

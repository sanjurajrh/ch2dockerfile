FROM registry.access.redhat.com/ubi8/ubi:8.0
ENV DOCROOT=/var/www/html
RUN yum -y install httpd --nodocs && yum clean all -y &&  \
    echo "IT WORKS" > ${DOCROOT}/index.html
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf
EXPOSE 8080
RUN rm -rf /run/httpd && mkdir /run/httpd
USER root
CMD /usr/sbin/httpd -DFOREGROUND

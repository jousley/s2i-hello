# attemp 1

#FROM registry.access.redhat.com/ubi9-minimal:latest
#
## Install nginx
#RUN microdnf install -y nginx && \
#    microdnf clean all
#
## Create directory for web content
#RUN mkdir -p /usr/share/nginx/html
#
## Copy the HTML file
#COPY index.html /usr/share/nginx/html/
#
## Copy nginx configuration
#COPY nginx.conf /etc/nginx/nginx.conf
#
## Expose port 8080 (non-privileged port)
#EXPOSE 8080
#
## Run nginx in foreground
#CMD ["nginx", "-g", "daemon off;"]




# attempt 2

FROM registry.access.redhat.com/ubi9-minimal:latest 
RUN microdnf -y update && \
    microdnf install -y nginx && \
    microdnf clean all

RUN mkdir -p /usr/share/nginx/html

COPY index.html /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
#COPY app.js /usr/share/nginx/html
#COPY styles.css /usr/share/nginx/html

EXPOSE 80

CMD /usr/sbin/nginx -g 'daemon off;'

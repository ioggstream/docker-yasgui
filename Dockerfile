FROM nginxinc/nginx-unprivileged
LABEL maintainer="erika.pauwels@gmail.com"

ENV ENABLE_ENDPOINT_SELECTOR false
ENV DEFAULT_SPARQL_ENDPOINT http://localhost/sparql

USER root
COPY index.html /usr/share/nginx/html/
COPY startup.sh /
RUN chmod +x /startup.sh
RUN chown 101 /usr/share/nginx/html/index.html

USER 101
ENTRYPOINT ["/startup.sh"]

CMD ["nginx", "-g", "daemon off;"]

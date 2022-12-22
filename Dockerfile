FROM nginx:1.15.8
LABEL maintainer="erika.pauwels@gmail.com"

ENV ENABLE_ENDPOINT_SELECTOR false
ENV DEFAULT_SPARQL_ENDPOINT http://localhost/sparql

RUN chown -R nginx:nginx /usr/share/nginx/html/ /var/cache/nginx/ /var/run/
COPY index.html /usr/share/nginx/html/
COPY startup.sh /
RUN chmod +x /startup.sh

ENTRYPOINT ["/startup.sh"]

CMD ["nginx", "-g", "daemon off;"]
USER nginx

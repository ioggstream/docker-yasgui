FROM nginxinc/nginx-unprivileged
LABEL maintainer="erika.pauwels@gmail.com"

ARG UID=101  # From nginxinc/nginx-unprivileged

ENV ENABLE_ENDPOINT_SELECTOR false
ENV DEFAULT_SPARQL_ENDPOINT http://localhost/sparql

# See https://developers.redhat.com/blog/2020/10/26/adapting-docker-and-kubernetes-containers-to-run-on-red-hat-openshift-container-platform#
#  for managing files with unprivileged images
USER root
COPY --chown=${UID}:0 index.html /usr/share/nginx/html/
COPY --chown=0:0 startup.sh /
RUN chmod a+x /startup.sh
RUN chgrp -R 0 /usr/share/nginx/html/ && \
	chmod -R g=u /usr/share/nginx/html/

USER ${UID}
ENTRYPOINT ["/startup.sh"]

CMD ["nginx", "-g", "daemon off;"]

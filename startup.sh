#!/bin/bash
set -e -o pipefail

if [ "$ENABLE_ENDPOINT_SELECTOR" == "true" ];
then
    sed -e '/\/\*\* endpoint-selector \*\//c\'"\/** .yasgui .endpointText {display:none !important;} *\/ \/** endpoint-selector *\/" /usr/share/nginx/html/index.html > /tmp/index.html && cp /tmp/index.html /usr/share/nginx/html/index.html
else
    sed -e '/\/\*\* endpoint-selector \*\//c\'".yasgui .endpointText {display:none !important;} \/** endpoint-selector *\/" /usr/share/nginx/html/index.html > /tmp/index.html && cp /tmp/index.html /usr/share/nginx/html/index.html

fi

sed -e '/default SPARQL endpoint/c\'"requestConfig: {endpoint: '$DEFAULT_SPARQL_ENDPOINT', method: 'GET'} \/\/ default SPARQL endpoint" /usr/share/nginx/html/index.html > /tmp/index.html && cp /tmp/index.html /usr/share/nginx/html/index.html


echo "Running with ${DEFAULT_SPARQL_ENDPOINT}"

exec "$@"

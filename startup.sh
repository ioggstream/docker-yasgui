#!/bin/bash

if [ "$ENABLE_ENDPOINT_SELECTOR" == "true" ];
then
    sed -i '/\/\*\* endpoint-selector \*\//c\'"\/** .yasgui .endpointText {display:none !important;} *\/ \/** endpoint-selector *\/" /usr/share/nginx/html/index.html
else
    sed -i '/\/\*\* endpoint-selector \*\//c\'".yasgui .endpointText {display:none !important;} \/** endpoint-selector *\/" /usr/share/nginx/html/index.html
fi

sed -i '/default SPARQL endpoint/c\'"requestConfig: {endpoint: '$DEFAULT_SPARQL_ENDPOINT', method: 'GET'} \/\/ default SPARQL endpoint" /usr/share/nginx/html/index.html

echo "Running with ${DEFAULT_SPARQL_ENDPOINT}"

exec "$@"

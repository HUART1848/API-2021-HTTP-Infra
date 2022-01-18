#!/usr/bin/sh
echo ajax:
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ajax_http

echo dynamic:
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dynamic_http

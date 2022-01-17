#!/usr/bin/sh
echo static:
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' static_http

echo dynamic:
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dynamic_http

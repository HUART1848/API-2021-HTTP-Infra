#!/usr/bin/sh
docker run --rm -p 8080:80 -v ${PWD}/conf/default.conf:/etc/nginx/conf.d/default.conf --name reverse_proxy huart1848/reverse-proxy

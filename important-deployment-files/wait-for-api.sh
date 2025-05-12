#!/bin/sh

host="sinaloa-api"
port="8080"

echo "Esperando a que la API esté disponible en $host:$port..."

while ! nc -z $host $port; do
  sleep 1
done

echo "API está disponible - iniciando Nginx"
exec "$@"
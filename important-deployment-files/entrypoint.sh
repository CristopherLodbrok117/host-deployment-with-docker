#!/bin/sh

# Configuración de seguridad base
JAVA_OPTS="-Djdk.tls.client.protocols=TLSv1.2"

# Verifica si debemos ejecutar seeders (ahora con SEED_DB)
if [ "$SEED_DB" = "true" ]; then
  echo "🔵 Ejecutando seeders..."
  ARGS="--seedAll"
else
  echo "⚪ Saltando seeders (SEED_DB no es 'true')"
  ARGS=""
fi

# Debug: Muestra variables relevantes
echo "🔍 Variables: SEED_DB=$SEED_DB, ARGS=$ARGS"

# Inicia la aplicación
exec java $JAVA_OPTS -jar sinaloa-api.jar $ARGS
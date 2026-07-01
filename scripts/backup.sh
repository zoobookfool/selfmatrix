#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f .env ]]; then
  echo ".env is missing."
  exit 1
fi

set -a
source .env
set +a

timestamp="$(date +%Y%m%d-%H%M%S)"
mkdir -p backups

docker compose exec -T postgres pg_dump -U "${POSTGRES_USER:-synapse}" "${POSTGRES_DB:-synapse}" > "backups/synapse-${timestamp}.sql"
tar -czf "backups/synapse-data-${timestamp}.tar.gz" synapse/data

echo "Wrote backups/synapse-${timestamp}.sql"
echo "Wrote backups/synapse-data-${timestamp}.tar.gz"

#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f .env ]]; then
  cp .env.example .env
  echo "Created .env. Edit it first, then run this script again."
  exit 1
fi

docker compose --profile generate run --rm synapse-generate

cat <<'MSG'

Generated synapse/data/homeserver.yaml.

Next:
1. Replace the database section with PostgreSQL settings from README.md.
2. Set public_baseurl to your MATRIX_HOST.
3. Keep enable_registration false for the private beta.
4. Run: docker compose up -d

MSG

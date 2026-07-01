#!/usr/bin/env bash
set -euo pipefail

docker compose exec synapse register_new_matrix_user -c /data/homeserver.yaml http://localhost:8008

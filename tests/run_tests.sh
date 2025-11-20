#!/bin/bash
set -euo pipefail
echo "Running quick smoke test..."
python - <<'PY'
from app import app
c = app.test_client()
rv = c.get('/health')
assert rv.status_code == 200
print("Health OK")
PY
echo "Tests passed."


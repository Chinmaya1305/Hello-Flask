#!/usr/bin/env bash
set -euo pipefail
mkdir -p dist
# artifact name: hello-devops-<build-number if provided via env> or timestamp
TAG="${BUILD_NUMBER:-local}-$(date +%Y%m%d%H%M%S)"
FNAME="hello-devops-${TAG}.tar.gz"
tar -czf "dist/${FNAME}" app.py requirements.txt start.sh README.md
echo "Created dist/${FNAME}"
ls -l dist


#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
python3 "$ROOT/scripts/check_config.py" "$ROOT/config/dx1_interconnect.yaml"
python3 "$ROOT/scripts/generate.py" --config "$ROOT/config/dx1_interconnect.yaml" --out "$ROOT/build/generated"
python3 -m py_compile "$ROOT/scripts/generate.py" "$ROOT/scripts/check_config.py"
grep -q 'DX1_SECURE_BOOT_BASE' "$ROOT/build/generated/dx1_interconnect_addr_map.h"
echo 'PASS: repository smoke checks'

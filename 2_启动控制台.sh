#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"

echo "======================================================================"
echo "  正在启动 Google AI Pro (5 TB) 零成本两年全自动控制台..."
echo "  控制台地址: http://127.0.0.1:8765"
echo "======================================================================"

if [[ ! -d .venv ]]; then
  echo "未找到 .venv，请先运行: ./1_首次运行_安装依赖并启动.sh"
  exit 1
fi
# shellcheck disable=SC1091
source .venv/bin/activate

(sleep 1.5 && (xdg-open "http://127.0.0.1:8765" >/dev/null 2>&1 || true)) &
exec python app.py

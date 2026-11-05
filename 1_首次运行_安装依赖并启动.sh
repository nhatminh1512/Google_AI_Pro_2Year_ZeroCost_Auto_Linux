#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"

echo "======================================================================"
echo "  正在检查并安装 Python 依赖 (fastapi, uvicorn, playwright)..."
echo "======================================================================"

if ! command -v python3 >/dev/null 2>&1; then
  echo "未找到 python3，请先安装 Python 3.10 或更高版本。"
  exit 1
fi

if [[ ! -d .venv ]]; then
  python3 -m venv .venv
fi
# shellcheck disable=SC1091
source .venv/bin/activate

python -m pip install -U pip
python -m pip install -r requirements.txt

if ! command -v google-chrome-stable >/dev/null 2>&1 \
  && ! command -v google-chrome >/dev/null 2>&1 \
  && ! command -v chromium-browser >/dev/null 2>&1 \
  && ! command -v chromium >/dev/null 2>&1 \
  && [[ -z "${CHROME_PATH:-}" ]]; then
  echo
  echo "警告: 未检测到 Google Chrome / Chromium。"
  echo "  Ubuntu/Debian 安装示例:"
  echo "    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  echo "    sudo apt-get install -y ./google-chrome-stable_current_amd64.deb"
  echo "  或设置环境变量: export CHROME_PATH=/path/to/chrome"
  echo
fi

echo
echo "======================================================================"
echo "  正在启动 Web 控制台 (http://127.0.0.1:8765) ..."
echo "======================================================================"

(sleep 1.5 && (xdg-open "http://127.0.0.1:8765" >/dev/null 2>&1 || true)) &
exec python app.py

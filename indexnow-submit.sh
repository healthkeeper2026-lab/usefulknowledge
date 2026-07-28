#!/usr/bin/env bash
# 수동 IndexNow 제출 — 터미널에서 ./indexnow-submit.sh 실행
set -euo pipefail

KEY="fd062fc105dc8dc8bd6451d82e5500ad"
HOST="healthkeeper2026-lab.github.io"
KEYLOC="https://healthkeeper2026-lab.github.io/usefulknowledge/fd062fc105dc8dc8bd6451d82e5500ad.txt"
BASE="https://healthkeeper2026-lab.github.io/usefulknowledge/"

echo "1) 키 파일 접근 확인..."
curl -sS -o /dev/null -w "   %{http_code}  $KEYLOC\n" "$KEYLOC"

echo "2) URL 제출..."
curl -sS -w "\n   HTTP %{http_code}\n" \
  -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{
    \"host\": \"$HOST\",
    \"key\": \"$KEY\",
    \"keyLocation\": \"$KEYLOC\",
    \"urlList\": [\"$BASE\"]
  }"

echo
echo "200 = 수신 완료 / 202 = 접수(키 검증 대기) / 403 = 키 파일 확인 불가 / 422 = host·URL 불일치"

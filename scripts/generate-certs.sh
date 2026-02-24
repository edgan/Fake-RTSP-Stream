#!/bin/sh
set -e

CERT_DIR="/certs"
CERT_FILE="$CERT_DIR/server.crt"
KEY_FILE="$CERT_DIR/server.key"

if [ -f "$CERT_FILE" ] && [ -f "$KEY_FILE" ]; then
  echo "Certificates already exist, skipping generation."
  exit 0
fi

echo "Generating self-signed TLS certificate..."
apk add --no-cache openssl
mkdir -p "$CERT_DIR"

openssl req -x509 \
  -newkey rsa:2048 \
  -sha256 \
  -days 3650 \
  -nodes \
  -keyout "$KEY_FILE" \
  -out "$CERT_FILE" \
  -subj "/CN=rtsp-server" \
  -addext "subjectAltName=DNS:rtsp-server,DNS:localhost,IP:127.0.0.1"

echo "Certificates generated successfully."

#!/usr/bin/env bash
# Builds a signed, installable plugin bundle zip the way `PrusaSlicer plugin sign` does,
# using only openssl and zip, so CI needs no PrusaSlicer binary.
#
#   scripts/build-bundle.sh <bundle dir> <private key pem> [out dir]
#
# The zip is flat (files at the root, no top-level directory) and contains
# manifest.txt (sha256 of every file) and manifest.sign (RSA PKCS#1 v1.5 / SHA-256
# signature of manifest.txt), which is what Plugins -> Install Plugin Bundle verifies
# against the author's public key in <config dir>/authorized_authors/<author>.pem.
set -euo pipefail

BUNDLE_DIR="${1:?bundle dir}"
PRIVATE_KEY="${2:?private key pem}"
OUT_DIR="${3:-.}"

BUNDLE_ID="$(python3 -c 'import json,sys;print(json.load(open(sys.argv[1]))["id"])' "$BUNDLE_DIR/manifest.json")"
[ "$(basename "$BUNDLE_DIR")" = "$BUNDLE_ID" ] || { echo "bundle dir must be named $BUNDLE_ID" >&2; exit 1; }

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
STAGE="$WORK/$BUNDLE_ID"
cp -R "$BUNDLE_DIR" "$STAGE"
rm -f "$STAGE/manifest.txt" "$STAGE/manifest.sign" "$STAGE/.DS_Store"

cd "$STAGE"
# Same restriction as the official signer.
if find . -type f | sed 's|^\./||' | LC_ALL=C grep -qv '^[A-Za-z0-9._ /-]*$'; then
    echo "file names may only contain [A-Za-z0-9._ -]" >&2; exit 1
fi
find . -type f ! -name manifest.txt ! -name manifest.sign | sed 's|^\./||' | LC_ALL=C sort > "$WORK/files"
while read -r f; do
    printf '%s  %s\n' "$(openssl dgst -sha256 -r "$f" | cut -d' ' -f1)" "$f"
done < "$WORK/files" > manifest.txt
openssl dgst -sha256 -sign "$PRIVATE_KEY" -out manifest.sign manifest.txt

mkdir -p "$OUT_DIR"
OUT_DIR="$(cd "$OUT_DIR" && pwd)"
ZIP="$OUT_DIR/$BUNDLE_ID.zip"
rm -f "$ZIP"
zip -q -X -r "$ZIP" . -x '.*'
echo "Wrote $ZIP"

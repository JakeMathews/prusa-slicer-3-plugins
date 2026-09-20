#!/usr/bin/env bash
# Re-downloads the official #3DBenchy single-part STL into the plugin bundle.
# The plugin itself cannot download anything (the PrusaSlicer Lua sandbox has no
# network or filesystem access), so the STL is committed; run this to refresh it.
set -euo pipefail

ZIP_URL="https://github.com/CreativeTools/3DBenchy/archive/master.zip"
BUNDLE="$(cd "$(dirname "$0")" && pwd)/com.github.jakemathews.benchy"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Downloading $ZIP_URL"
curl -fsSL -o "$TMP/3DBenchy.zip" "$ZIP_URL"
unzip -q -o -j "$TMP/3DBenchy.zip" "3DBenchy-master/Single-part/3DBenchy.stl" -d "$TMP"
mv "$TMP/3DBenchy.stl" "$BUNDLE/3DBenchy.stl"

echo "Wrote $BUNDLE/3DBenchy.stl"
shasum -a 256 "$BUNDLE/3DBenchy.stl"

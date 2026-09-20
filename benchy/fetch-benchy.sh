#!/usr/bin/env bash
# Re-downloads the official #3DBenchy STLs into the plugin bundle.
# The plugin itself cannot download anything (the PrusaSlicer Lua sandbox has no
# network or filesystem access), so the STLs are committed; run this to refresh them.
set -euo pipefail

ZIP_URL="https://github.com/CreativeTools/3DBenchy/archive/master.zip"
BUNDLE="$(cd "$(dirname "$0")" && pwd)/com.github.jakemathews.benchy"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Downloading $ZIP_URL"
curl -fsSL -o "$TMP/3DBenchy.zip" "$ZIP_URL"
unzip -q -o "$TMP/3DBenchy.zip" -d "$TMP"
SRC="$TMP/3DBenchy-master"

cp "$SRC/Single-part/3DBenchy.stl" "$BUNDLE/3DBenchy.stl"
cp "$SRC/Multi-part/#3DBenchy - Dualprint - Hull, Box, Bridge walls, Rod-holder, Chimney - (3DBenchy.com).stl" "$BUNDLE/dual-hull.stl"
cp "$SRC/Multi-part/#3DBenchy - Dualprint - Gunwale, Deck, Plate, Wheel, Frames, Roof, Chimney top - (3DBenchy.com).stl" "$BUNDLE/dual-deck.stl"
for f in "$SRC"/Multi-part/*" - Multi-part - Single - "*.stl; do
    name="$(basename "$f")"
    name="${name#*Multi-part - Single - }"
    name="${name% - (3DBenchy.com).stl}"
    name="$(printf '%s' "$name" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-|-$//g')"
    cp "$f" "$BUNDLE/part-$name.stl"
done

echo "Wrote STLs to $BUNDLE"
(cd "$BUNDLE" && shasum -a 256 -- *.stl)

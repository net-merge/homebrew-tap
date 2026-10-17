#!/usr/bin/env bash
# Rewrites Formula/net-merge.rb from the latest net-merge release (version and SHA-256 of each
# tarball, taken from the GitHub release assets). Leaves the formula alone if an asset is missing.
set -euo pipefail
cd "$(dirname "$0")/.."
rel=$(gh api repos/rohit267/net-merge/releases/latest)
tag=$(jq -r .tag_name <<<"$rel"); v=${tag#v}
sha() { jq -r --arg n "net-merge-$v-$1.tar.gz" '.assets[] | select(.name == $n) | .digest | sub("sha256:"; "")' <<<"$rel"; }
m=$(sha macos-universal); x=$(sha linux-x86_64); a=$(sha linux-aarch64)
for s in "$m" "$x" "$a"; do
    [ -n "$s" ] || { echo "release $tag has no complete set of tarballs yet; leaving the formula alone"; exit 0; }
done
sed -e "s/@VERSION@/$v/g" -e "s/@SHA_MACOS@/$m/" -e "s/@SHA_LINUX_X86_64@/$x/" -e "s/@SHA_LINUX_AARCH64@/$a/" \
    formula.rb.in > Formula/net-merge.rb
echo "formula is at $v"

#!/usr/bin/env bash
# Update kata-containers to the latest release: bumps pkgver and refreshes sha256sums.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

release=$(curl -fsSL -H "Accept: application/vnd.github+json" https://api.github.com/repos/kata-containers/kata-containers/releases/latest)
ver=$(echo "$release" | jq -r '.tag_name')

# Release tarballs use architecture names that differ from uname -m.
case "$(uname -m)" in
  x86_64)  ARCH=amd64 ;;
  aarch64) ARCH=arm64 ;;
  *)
    echo "unsupported architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

# No checksum assets are published, so hash the tarballs ourselves.
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
for arch in amd64 arm64; do
  curl -fsSL -o "$tmp/kata-static-$ver-$arch.tar.zst" \
    "https://github.com/kata-containers/kata-containers/releases/download/$ver/kata-static-$ver-$arch.tar.zst" &
done
wait
for arch in amd64 arm64; do
  sum=$(sha256sum "$tmp/kata-static-$ver-$arch.tar.zst" | cut -d' ' -f1)
  case "$arch" in
    amd64) sed -i -E "s/^_sha256_x86_64=.*/_sha256_x86_64='$sum'/" PKGBUILD ;;
    arm64) sed -i -E "s/^_sha256_aarch64=.*/_sha256_aarch64='$sum'/" PKGBUILD ;;
  esac
done
sed -i -E "s/^pkgver=.*/pkgver=$ver/" PKGBUILD

makepkg --printsrcinfo > .SRCINFO

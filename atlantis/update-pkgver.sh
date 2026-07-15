#!/usr/bin/env bash
# Update atlantis to the latest release: bumps pkgver and refreshes sha256sums.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

release=$(curl -fsSL -H "Accept: application/vnd.github+json" https://api.github.com/repos/runatlantis/atlantis/releases/latest)

ver=$(echo "$release" | jq -r '.tag_name | ltrimstr("v")')
sum_x86_64=$(echo "$release" | jq -r '.assets[] | select(.name == "atlantis_linux_amd64.zip") | .digest | ltrimstr("sha256:")')
sum_aarch64=$(echo "$release" | jq -r '.assets[] | select(.name == "atlantis_linux_arm64.zip") | .digest | ltrimstr("sha256:")')

sed -i -E "s/^pkgver=.*/pkgver=$ver/" PKGBUILD
sed -i -E "s/^sha256sums=.*/sha256sums=('$sum_x86_64')/" PKGBUILD
sed -i -E "s/^sha256sums_aarch64=.*/sha256sums_aarch64=('$sum_aarch64')/" PKGBUILD

makepkg --printsrcinfo > .SRCINFO

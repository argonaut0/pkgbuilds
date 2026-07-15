#!/usr/bin/env bash
# Regenerate .SRCINFO for every package in this repo.
#
# Usage: ./regen-srcinfo.sh
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for pkgbuild in "$repo_root"/*/PKGBUILD; do
	dir="$(dirname "$pkgbuild")"
	(cd "$dir" && makepkg --printsrcinfo > .SRCINFO)
	echo "regenerated ${dir##*/}/.SRCINFO"
done

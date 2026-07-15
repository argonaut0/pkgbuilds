#!/usr/bin/env bash
# Clone an AUR package (files only) into this repo for easy editing.
#
# Usage: ./import-aur.sh <pkgname> [<pkgname> ...]
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for pkg in "$@"; do
	tmp="$(mktemp -d)"
	git clone --depth 1 "https://aur.archlinux.org/${pkg}.git" "$tmp/$pkg"
	rm -rf "$tmp/$pkg/.git"
	mkdir -p "$repo_root/$pkg"
	cp -a "$tmp/$pkg/." "$repo_root/$pkg/"
	rm -rf "$tmp"
	echo "imported $pkg"
done

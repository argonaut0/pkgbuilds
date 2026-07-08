#!/usr/bin/env bash
sed -i -E "s/^pkgver=.*/pkgver=$(curl -fsSL -H "Accept: application/vnd.github+json" https://api.github.com/repos/google/gvisor/tags | jq -r '.[0].name | split("-")[1]')/" PKGBUILD
sed -i -E "s/^_sha512_bin_x86_64=.*/_sha512_bin_x86_64='$(curl -fsSL https://storage.googleapis.com/gvisor/releases/release/latest/x86_64/runsc.sha512 | cut -d' ' -f1)'/" PKGBUILD
sed -i -E "s/^_sha512_shim_x86_64=.*/_sha512_shim_x86_64='$(curl -fsSL https://storage.googleapis.com/gvisor/releases/release/latest/x86_64/containerd-shim-runsc-v1.sha512 | cut -d' ' -f1)'/" PKGBUILD
sed -i -E "s/^_sha512_bin_aarch64=.*/_sha512_bin_aarch64='$(curl -fsSL https://storage.googleapis.com/gvisor/releases/release/latest/aarch64/runsc.sha512 | cut -d' ' -f1)'/" PKGBUILD
sed -i -E "s/^_sha512_shim_aarch64=.*/_sha512_shim_aarch64='$(curl -fsSL https://storage.googleapis.com/gvisor/releases/release/latest/aarch64/containerd-shim-runsc-v1.sha512 | cut -d' ' -f1)'/" PKGBUILD
makepkg --printsrcinfo > .SRCINFO

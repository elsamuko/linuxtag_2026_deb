#!/usr/bin/env bash

# exit on error
set -e

# make new file permissions 755/644
umask 0022

rm -rf linuxtag-2026
mkdir -p linuxtag-2026
mkdir -p linuxtag-2026/DEBIAN
mkdir -p linuxtag-2026/usr/bin
mkdir -p linuxtag-2026/usr/share/doc/linuxtag
mkdir -p linuxtag-2026/usr/share/man/man1
mkdir -p linuxtag-2026/usr/share/linuxtag/
cp linuxtag_2026.py linuxtag-2026/usr/bin/linuxtag_2026
cp linuxtag.service linuxtag-2026/usr/share/linuxtag/linuxtag.service

cp postinst linuxtag-2026/DEBIAN/postinst
cp prerm linuxtag-2026/DEBIAN/prerm

cat << EOF > linuxtag-2026/usr/share/doc/linuxtag/copyright
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Copyright 2026 Samuel <elsamuko@gmail.com>
EOF

# https://www.debian.org/doc/debian-policy/ch-controlfields.html
cat << EOF > linuxtag-2026/DEBIAN/control
Package: linuxtag
Version: 1.0-1
Architecture: all
Section: misc
Priority: optional
Depends: python3
Maintainer: Samuel <elsamuko@gmail.com>
Description: Example package for Linuxtag
 Some more details...
EOF

# changelog
gzip -n -9 -c CHANGELOG > linuxtag-2026/usr/share/doc/linuxtag/changelog.Debian.gz

dpkg-deb --root-owner-group --build linuxtag-2026
lintian linuxtag-2026.deb

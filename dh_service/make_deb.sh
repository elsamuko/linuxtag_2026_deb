#!/usr/bin/env bash
# https://github.com/FooBarWidget/debian-packaging-for-the-modern-developer/blob/master/tutorial-3/README.md

# exit on error
set -e

if [ -d linuxtag-2026 ]; then rm -rf linuxtag-2026; fi
mkdir -p linuxtag-2026/debian
cp linuxtag_2026.py linuxtag-2026/linuxtag_2026

cat << EOF > linuxtag-2026/debian/install
linuxtag_2026 usr/bin
EOF

cat << EOF > linuxtag-2026/debian/copyright
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Copyright 2026 Samuel <elsamuko@gmail.com>
EOF

# https://www.debian.org/doc/debian-policy/ch-controlfields.html
cat << EOF > linuxtag-2026/debian/control
Source: linuxtag
Section: misc
Priority: optional
Maintainer: Samuel <elsamuko@gmail.com>
Build-Depends: debhelper-compat (= 13)

Package: linuxtag
Architecture: all
Depends: python3
Description: Example package for Linuxtag
 Some more details...
EOF

cp linuxtag.service linuxtag-2026/debian
cp rules linuxtag-2026/debian
# https://manpages.debian.org/testing/debhelper/debhelper-compat-upgrade-checklist.7.en.html
cp ../simple/CHANGELOG linuxtag-2026/debian/changelog
echo "debian/linuxtag.1" > linuxtag-2026/debian/linuxtag.manpages
ronn --roff --pipe --name=linuxtag ../simple/linuxtag_2026.1.ronn > linuxtag-2026/debian/linuxtag.1

(
    cd linuxtag-2026
    dpkg-buildpackage -b --no-sign
    lintian ../linuxtag_1.0-1_all.deb
)

dpkg-deb --info linuxtag*.deb
dpkg-deb --contents linuxtag*.deb

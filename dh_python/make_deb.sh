#!/usr/bin/env bash
# python3 -m pip install uv --b
# sudo apt install python3-hatchling

PATH="$PATH":~/.local/bin

if [ -d linuxtag ]; then
    rm -rf linuxtag*
fi

uv init --package linuxtag --build-backend hatch
(
    cd linuxtag || exit
    uv add requests
)

mkdir -p linuxtag/debian

cat << EOF > linuxtag/debian/control
Source: linuxtag
Priority: optional
Section: misc
Maintainer: Samuel <elsamuko@gmail.com>
Build-Depends: debhelper-compat (= 13),
               dh-python,
               python3-all,
               python3-setuptools,
               python3-build,
               pybuild-plugin-pyproject

Package: linuxtag
Depends: \${python3:Depends}, \${misc:Depends}
Architecture: all
Description: linuxtagnapp
 prints linuxtag
EOF

cat << EOF > linuxtag/debian/rules
#!/usr/bin/make -f

%:
	dh \$@ --with python3 --buildsystem=pybuild
EOF

cat << EOF > linuxtag/debian/changelog
linuxtag (1.0-1) unstable; urgency=medium

  * Initial release.

 -- Samuel <elsamuko@gmail.com>  $(date -R)
EOF

cat << EOF > linuxtag/debian/copyright
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Files:
 *
Copyright: 2024-$(date +%Y) elsamuko
License: Proprietary
EOF

(
    cd linuxtag || exit
    dpkg-buildpackage -us -uc
)

dpkg-deb --info linuxtag*.deb
dpkg-deb --contents linuxtag*.deb

#!/usr/bin/env bash
# sudo apt install dh-virtualenv virtualenv

# exit on error
set -e

if [ -d linuxtag ]; then
    rm -rf linuxtag/
fi

mkdir -p linuxtag/debian

cp linuxtag_2026.py linuxtag/linuxtag_2026.py

cat << EOF > linuxtag/pyproject.toml
[build-system]
requires = ["setuptools"]
build-backend = "setuptools.build_meta"

[project]
name = "linuxtag"
version = "1.0"
requires-python = ">=3.8"

[project.scripts]
linuxtag_2026 = "linuxtag_2026:main"
EOF

cat << EOF > linuxtag/debian/links
/opt/venvs/linuxtag/bin/linuxtag_2026 usr/bin/linuxtag
EOF

cat << EOF > linuxtag/debian/control
Source: linuxtag
Priority: optional
Section: misc
Maintainer: Samuel <elsamuko@gmail.com>
Build-Depends: debhelper-compat (= 13),
               dh-virtualenv,
               python3,
               python3-dev

Package: linuxtag
Depends: \${misc:Depends}
Architecture: all
Description: linuxtagapp
 prints linuxtag
EOF

cat << EOF > linuxtag/debian/requirements.txt
cryptography
EOF

cat << EOF > linuxtag/debian/rules
#!/usr/bin/make -f

export DH_VIRTUALENV_INSTALL_ROOT=/opt/venvs

%:
	dh \$@ --with python-virtualenv

override_dh_virtualenv:
	dh_virtualenv \
		--python /usr/bin/python3 \
		--requirements debian/requirements.txt
EOF
chmod +x linuxtag/debian/rules

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
# dpkg-deb --contents linuxtag*.deb

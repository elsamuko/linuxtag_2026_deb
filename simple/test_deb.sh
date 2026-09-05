#!/usr/bin/env bash

function separator {
    printf "\n%-$(tput cols)s\n" "--$*" | tr " " "-"
}

separator "reinstall"
sudo apt reinstall -y ./linuxtag-2026.deb

separator "version"
linuxtag_2026 --version

separator "man"
man linuxtag_2026 | tee

separator "uninstall"
sudo apt remove -y linuxtag

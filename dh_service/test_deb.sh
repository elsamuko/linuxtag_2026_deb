#!/usr/bin/env bash

function separator {
    printf "\n%-$(tput cols)s\n" "--$*" | tr " " "-"
}

separator "reinstall"
sudo apt reinstall -y ./linuxtag_1.0-1_all.deb

separator "check service"
sudo systemctl status linuxtag.service

separator "check service with curl"
curl http://localhost:8080
echo

separator "remove"
sudo apt purge -y linuxtag

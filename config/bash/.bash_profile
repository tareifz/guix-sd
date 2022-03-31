# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

export FLATPAK_DIRS=/var/lib/flatpak/exports/share:/home/tareifz/.local/share/flatpak/exports/share
export XDG_DATA_DIRS=$XDG_DATA_DIRS:$FLATPAK_DIRS
export DOCKER_APPS_DIR=/home/tareifz/guix-sd/docker-apps/bin

export PATH=$DOCKER_APPS_DIR:$PATH

sh ./tareifz-session.sh

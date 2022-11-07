(define-module (tareifz home env)
  #:use-module (gnu services)
  #:use-module (gnu home services))

(define-public %tareifz-home-env-vars
  (simple-service 'tareifz-home-envs
                  home-environment-variables-service-type
                  `(("GUILE_LOAD_PATH" . "$HOME/guix-sd/")
                    ("FLATPAK_DIRS" . "/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share")
                    ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:$FLATPAK_DIRS"))))

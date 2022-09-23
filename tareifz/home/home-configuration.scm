;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.
(define-module (tareifz home home-configuration)
  #:use-module (guix gexp)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells))

(define %tareifz-home-bash-service
  (service
   home-bash-service-type
   (home-bash-configuration
    (aliases
     '(("grep" . "grep --color=auto")
       ("ll" . "ls -l")
       ("ls" . "ls -p --color=auto")))
    (bashrc
     (list (local-file
            "files/.bashrc"
            "bashrc")))
    (bash-profile
     (list (local-file
            "files/.bash_profile"
            "bash_profile"))))))

(define %tareifz-home-env-vars
  (simple-service 'tareifz-home-envs
                  home-environment-variables-service-type
                  `(("GUILE_LOAD_PATH" . "$HOME/guix-sd/")
                    ("FLATPAK_DIRS" . "/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share")
                    ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:$FLATPAK_DIRS")
                    ("DOCKER_APPS_DIR" . "$HOME/guix-sd/docker-apps/bin")
                    ("PATH" . "$DOCKER_APPS_DIR:$PATH")
                    ("GPG_TTY" . "$(tty)"))))

(define %tareifz-home-files
  (simple-service 'tareifz-home-files
                  home-files-service-type
                  `(("tareifz-session.sh" ,(local-file "files/tareifz-session.sh"))
                    (".gitconfig" ,(local-file "files/git/gitconfig"))
                    (".gitignore" ,(local-file "files/git/gitignore")))))

(home-environment
 (packages (list emacs))
 (services
  (list %tareifz-home-files
        %tareifz-home-bash-service
        %tareifz-home-env-vars)))

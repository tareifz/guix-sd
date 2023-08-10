;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.
(define-module (tareifz home home-configuration)
  #:use-module (gnu services)
  #:use-module (gnu packages)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services shells)
  #:use-module (guix channels)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:))

(define-public base-packages
  (specifications->packages
   (list
    "alacritty"
    "emacs"
    "curl"
    "nss-certs"
    "sbcl"
    "git"
    "gnupg"
    "pinentry"
    "unzip"
    "intel-vaapi-driver"
    "libva-utils"
    "flatpak"
    "firefox"
    "openjdk:jdk"
    "clojure"
    "clojure-tools"
    "leiningen"
    "rust"
    "rust:cargo"
    "rust:rustfmt")))

(define-public font-packages
  (map specification->package
       (list
        "fontconfig"
        "font-terminus"
        "font-awesome"
        "font-ghostscript"
        "font-dejavu"
        "font-gnu-freefont"
        ;; for Japan, China, Korea
        "font-adobe-source-han-sans"
        "font-wqy-zenhei"
        "font-fira-code")))

;; inspired by github/Tass0sm
(define-public tareifz-home-docker-apps
  (package
   (name "home-docker-apps")
   (version "0.1")
   (source (local-file "files/docker-apps"
                       #:recursive? #t))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan
      '(("crystal.sh" "bin/crystal")
        ("deno.sh" "bin/deno")
        ("node.sh" "bin/node"))))
   (home-page "https://github.com/tareifz/guix-sd")
   (synopsis "Apps used through Docker.")
   (description "Apps used through Docker.")
   (license license:gpl3+)))

(define-public tareifz-home-files
  (simple-service 'tareifz-home-files
                  home-files-service-type
                  `(("tareifz-session.sh" ,(local-file "files/tareifz-session.sh"))
                    (".gitconfig" ,(local-file "files/git/gitconfig"))
                    (".gitignore" ,(local-file "files/git/gitignore"))
                    ("wallpapers/wallhaven-103837.jpg" ,(local-file "files/wallpapers/wallhaven-103837.jpg"))
                    ("wallpapers/wallhaven-168676.jpg" ,(local-file "files/wallpapers/wallhaven-168676.jpg"))
                    (".local/share/applications/emacs.desktop" ,(local-file "files/gnome/emacs.desktop"))
                    (".sbclrc" ,(local-file "files/sbcl/sbclrc")))))

(define-public tareifz-home-xdg-configuration-files
  (simple-service 'tareifz-home-xdg-configuration-files
                  home-xdg-configuration-files-service-type
                  `(("alacritty/alacritty.yml" ,(local-file "files/alacritty/alacritty.yml"))
                    ("gnupg/gpg-agent.conf" ,(local-file "files/gnupg/gpg-agent.conf"))
                    ("rofi" ,(local-file "files/rofi" #:recursive? #t))
                    ("shepherd/init.scm" ,(local-file "files/shepherd/init.scm"))
                    ("emacs/init.el" ,(local-file "files/emacs/init.el"))
                    ("emacs/templates" ,(local-file "files/emacs/templates" #:recursive? #t))
                    ("emacs/lisp" ,(local-file "files/emacs/lisp" #:recursive? #t))
                    ("emacs/themes" ,(local-file "files/emacs/themes" #:recursive? #t)))))

(define-public tareifz-home-bash-service
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

(define-public tareifz-home-env-vars
  (simple-service 'tareifz-home-envs
                  home-environment-variables-service-type
                  `(("GUILE_LOAD_PATH" . "$HOME/guix-sd/")
                    ("FLATPAK_DIRS" . "/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share")
                    ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:$FLATPAK_DIRS"))))

(define-public tareifz-home-channels
  (simple-service 'nonguix-chennel-service
                  home-channels-service-type
                  (list
                   (channel
                    (name 'nonguix)
                    (url "https://gitlab.com/nonguix/nonguix")))))

(home-environment
 (packages `(,@base-packages
             ,@font-packages
             ,tareifz-home-docker-apps))
 (services
  (list tareifz-home-files
        tareifz-home-xdg-configuration-files
        tareifz-home-bash-service
        tareifz-home-env-vars
        tareifz-home-channels)))

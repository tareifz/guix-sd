(define-module (tareifz home xdg)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu home services))

(define-public %tareifz-home-xdg-configuration-files
  (simple-service 'tareifz-home-xdg-configuration-files
                  home-xdg-configuration-files-service-type
                  `(("alacritty/alacritty.yml" ,(local-file "files/alacritty/alacritty.yml"))
                    ("gnupg/gpg-agent.conf" ,(local-file "files/gnupg/gpg-agent.conf"))
                    ("rofi/summerfruit.rasi" ,(local-file "files/rofi/summerfruit.rasi"))
                    ("rofi/flat-red.rasi" ,(local-file "files/rofi/flat-red.rasi"))
                    ("shepherd/init.scm" ,(local-file "files/shepherd/init.scm"))
                    ("emacs/init.el" ,(local-file "files/emacs/init.el"))
                    ("emacs/templates/crystal.cr" ,(local-file "files/emacs/templates/crystal.cr")))))

(define-module (tareifz home files)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu home services))

(define-public %tareifz-home-files
  (simple-service 'tareifz-home-files
                  home-files-service-type
                  `(("tareifz-session.sh" ,(local-file "files/tareifz-session.sh"))
                    (".gitconfig" ,(local-file "files/git/gitconfig"))
                    (".gitignore" ,(local-file "files/git/gitignore"))
                    ("wallpapers/wallhaven-103837.jpg" ,(local-file "files/wallpapers/wallhaven-103837.jpg"))
                    ("wallpapers/wallhaven-168676.jpg" ,(local-file "files/wallpapers/wallhaven-168676.jpg"))
                    (".local/share/applications/emacs.desktop" ,(local-file "files/gnome/emacs.desktop")))))

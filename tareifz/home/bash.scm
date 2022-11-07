(define-module (tareifz home bash)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (guix gexp))

(define-public %tareifz-home-bash-service
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

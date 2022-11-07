(define-module (tareifz home docker-apps)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:))

;; inspired by github/Tass0sm
(define-public %home-docker-apps
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

;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.
(define-module (tareifz home home-configuration)
  #:use-module (gnu home)
  #:use-module (tareifz home packages)
  #:use-module (tareifz home files)
  #:use-module (tareifz home xdg)
  #:use-module (tareifz home bash)
  #:use-module (tareifz home env)
  #:use-module (tareifz home docker-apps)
  #:use-module (tareifz home channels))

(home-environment
 (packages `(,@base-packages
             ,@font-packages
             ,%home-docker-apps))
 (services
  (list %tareifz-home-files
        %tareifz-home-xdg-configuration-files
        %tareifz-home-bash-service
        %tareifz-home-env-vars
        %tareifz-home-channels)))

(define-module (tareifz home channels)
  #:use-module (guix channels)
  #:use-module (gnu services)
  #:use-module (gnu home services guix))

(define-public %tareifz-home-channels
  (simple-service 'nonguix-chennel-service
                  home-channels-service-type
                  (list
                   (channel
                    (name 'nonguix)
                    (url "https://gitlab.com/nonguix/nonguix")))))

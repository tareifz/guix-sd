(define-module (tareifz system desktop)
  #:use-module (gnu)
  #:use-module (tareifz system base))

(define-public %tareifz-desktop-os
  (operating-system
   (inherit %tareifz-base-os)
   (file-systems (cons* (file-system
                         (device (file-system-label "my-root"))
                         (mount-point "/")
                         (type "ext4"))
                        (file-system
                         (device "/dev/sda1")
                         (mount-point "/boot/efi")
                         (type "vfat")) %base-file-systems))))

%tareifz-desktop-os

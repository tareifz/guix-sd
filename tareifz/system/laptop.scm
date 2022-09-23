(define-module (tareifz system laptop)
  #:use-module (gnu)
  #:use-module (tareifz system base))

(define-public %tareifz-laptop-os
  (operating-system
   (inherit %tareifz-base-os)
   (file-systems (cons* (file-system
                         (device (file-system-label "my-root"))
                         (mount-point "/")
                         (type "ext4"))
                        (file-system
                         (device "/dev/nvme0n1p1")
                         (mount-point "/boot/efi")
                         (type "vfat")) %base-file-systems))))

%tareifz-laptop-os

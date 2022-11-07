(define-module (tareifz system base)
  #:use-module (srfi srfi-1)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages video)
  #:use-module (gnu services desktop)
  #:use-module (gnu services xorg)
  #:use-module (gnu services docker)
  #:use-module (gnu services networking)
  #:use-module (gnu services ssh)
  #:use-module (guix channels)
  #:use-module (guix inferior)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (nongnu packages mozilla))

(define-public %tareifz-base-os
  (operating-system
   (host-name "tareifz-spirits")
   (timezone "Asia/Riyadh")
   (locale "en_US.utf8")

   ;; Choose US English keyboard layout.  The "altgr-intl"
   ;; variant provides dead keys for accented characters.
   (keyboard-layout (keyboard-layout "us" "altgr-intl"))

   (kernel linux)
   (initrd microcode-initrd)
   (firmware (list linux-firmware))

   ;; Use the UEFI variant of GRUB with the EFI System
   ;; Partition mounted on /boot/efi.
   (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

   (file-systems (cons* (file-system
                         (device (file-system-label "my-root"))
                         (mount-point "/")
                         (type "ext4"))
                        (file-system
                         (device "/dev/nvme0n1p1")
                         (mount-point "/boot/efi")
                         (type "vfat")) %base-file-systems))

   (users (cons (user-account
                 (name "tareifz")
                 (comment "Tareif Al-Zamil")
                 (group "users")
                 (supplementary-groups '("wheel" "netdev" "audio" "video"
                                         "docker"))) %base-user-accounts))

   ;; This is where we specify system-wide packages.
   (packages (cons* emacs
                    git
                    rust
                    (list rust "cargo")
                    (list rust "rustfmt")
                    rust-analyzer
                    fontconfig
                    font-terminus
                    font-awesome
                    font-ghostscript
                    font-dejavu
                    font-gnu-freefont
                    ;; for Japan, China, Korea
                    font-adobe-source-han-sans
                    font-wqy-zenhei
                    font-fira-code
                    gnupg
                    pinentry
                    openssh
                    unzip
                    intel-vaapi-driver
                    libva-utils
                    firefox
                    nss-certs
                    %base-packages))

   (services
    (cons* (service gnome-desktop-service-type)
           (service docker-service-type)
           (modify-services
            %desktop-services
            (guix-service-type
             config =>
             (guix-configuration
              (inherit config)
              (substitute-urls (cons* "https://substitutes.nonguix.org"
                                      %default-substitute-urls))
              (authorized-keys (cons* (local-file "../.keys/non-guix.pub")
                                      %default-authorized-guix-keys)))))))))

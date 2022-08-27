;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS.

(use-modules (gnu)
             (srfi srfi-1)
             (gnu packages emacs)
             (gnu packages wm)
             (gnu packages xorg)
             (gnu packages version-control)
             (gnu packages terminals)
             (gnu packages xdisorg)
             (gnu packages rust)
             (gnu packages rust-apps)
             (gnu packages lisp)
             (gnu packages certs)
             (gnu packages package-management)
             (gnu packages fonts)
             (gnu packages fontutils)
             (gnu packages ghostscript)
             (gnu packages shells)
             (gnu packages ssh)
             (gnu packages compression)
             (gnu packages gnupg)
             (gnu packages video)
             (gnu packages package-management)
             (gnu services desktop)
             (gnu services xorg)
             (gnu services docker)
             (guix channels)
             (guix inferior)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (nongnu packages mozilla))

(use-service-modules networking ssh)
(use-package-modules screen gnome)

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
              (target "/boot/efi")
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
                  sbcl
                  alacritty
                  git
                  stow
                  rust
                  (list rust "cargo")
                  (list rust "rustfmt")
                  rust-analyzer
                  fontconfig
                  font-terminus
                  font-awesome
                  gs-fonts
                  font-dejavu
                  font-gnu-freefont
                  font-fira-code
                  fish
                  gnupg
                  pinentry
                  openssh
                  unzip
                  intel-vaapi-driver
                  libva-utils
                  flatpak
                  firefox
                  nss-certs
                  %base-packages))

 (services
  (cons* (service gnome-desktop-service-type)
         (service docker-service-type)
         (modify-services %desktop-services
                          (guix-service-type config =>
                                             (guix-configuration (inherit config)
                                                                 (substitute-urls (append (list
                                                                                           "https://substitutes.nonguix.org")
                                                                                          %default-substitute-urls))
                                                                 (authorized-keys (append (list
                                                                                           (plain-file
                                                                                            "non-guix.pub"
                                                                                            "(public-key
 (ecc
  (curve Ed25519)
  (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)
  )
 )
"))
                                                                                          %default-authorized-guix-keys))))))))

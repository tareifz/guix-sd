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
       (gnu packages java)
       (gnu packages lisp)
       (gnu packages certs)
       (gnu packages package-management)
       (gnu packages fonts)
       (gnu packages fontutils)
       (gnu packages ghostscript)
       (gnu packages shells)
       (gnu packages web-browsers)
       (gnu packages ssh)
       (gnu packages compression)
       (gnu packages gnupg)
       (gnu packages video)
       (gnu packages package-management)
       (gnu services desktop)
       (gnu services xorg)
       (guix channels)
       (guix inferior)
       (nongnu packages linux)
       (nongnu system linux-initrd))

(use-service-modules networking ssh)
(use-package-modules screen gnome)

(operating-system
  (host-name "tareifz-spirits")
  (timezone "Asia/Riyadh")
  (locale "en_US.utf8")

  ;; Choose US English keyboard layout.  The "altgr-intl"
  ;; variant provides dead keys for accented characters.
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))

  (kernel
    (let*
      ((channels
        (list (channel
               (name 'nonguix)
               (url "https://gitlab.com/nonguix/nonguix")
               (commit "fcab975d18c42be847d3b8cd907e20bfda7f551e"))
              (channel
               (name 'guix)
               (url "https://git.savannah.gnu.org/git/guix.git")
               (commit "320c971f8e44abc65ed162f20cc93edbb07bd5f5"))))
       (inferior
        (inferior-for-channels channels)))
      (first (lookup-inferior-packages inferior "linux" "5.14.8"))))

  (initrd microcode-initrd)
  (firmware  (list linux-firmware))

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
                        (type "vfat"))
                 %base-file-systems))

  (users (cons (user-account
                (name "tareifz")
                (comment "Tareif Al-Zamil")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video")))
               %base-user-accounts))

  ;; This is where we specify system-wide packages.
  (packages (cons* emacs
       sbcl
       alacritty
       git
       stow
       rust-1.52
       (list rust-1.52 "cargo")
       (list rust-1.52 "rustfmt")
       (list rust-1.52 "doc")
       openjdk16
       (list openjdk16 "jdk")
       fontconfig
       font-terminus
       font-awesome
       gs-fonts
       font-dejavu
       font-gnu-freefont
       fish
       gnupg
       pinentry
       openssh
       unzip
       intel-vaapi-driver
       libva-utils
       flatpak
       nss-certs
       %base-packages))

  (services (cons* (service gnome-desktop-service-type)
        %desktop-services)))

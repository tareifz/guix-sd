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
	     (gnu packages pulseaudio)
	     (gnu packages video)
	     (gnu packages gstreamer)
	     (gnu packages package-management)
	     (gnu services desktop)
	     (gnu services xorg)
	     (guix channels)
	     (guix inferior)
             (nongnu packages linux)
             (nongnu system linux-initrd)
	     )

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
               (commit "05107f1b94e24fa37a01ccbe51b8579846ecf792"))
              (channel
               (name 'guix)
               (url "https://git.savannah.gnu.org/git/guix.git")
               (commit "2c9d481c9098e18accd179f11edc1164e75f228e"))))
       (inferior
        (inferior-for-channels channels)))
      (first (lookup-inferior-packages inferior "linux" "5.10.11"))))

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
		   stumpwm
		   `(,stumpwm "lib")
		   dzen
		   xsetroot
		   sbcl
		   rofi
		   alacritty
		   git
		   stow
		   rust
		   fontconfig
		   font-terminus
		   font-awesome
		   gs-fonts
		   font-dejavu
		   font-gnu-freefont
		   sbcl-stumpwm-ttf-fonts
		   fish
		   nyxt
		   gnupg
		   openssh
		   unzip
		   pamixer
		   gstreamer
		   gst-plugins-base
		   gst-plugins-good
		   gst-plugins-bad
		   gst-plugins-ugly
		   gst-libav
		   intel-vaapi-driver
		   libva-utils
		   pulseaudio
		   flatpak
		   nss-certs
		   %base-packages))

  (services (cons* (service slim-service-type)
		   (remove (lambda (service)
		      (eq? (service-kind service) gdm-service-type))
		    %desktop-services))))

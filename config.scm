;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS.

(use-modules (gnu)
	     (srfi srfi-1)
	     (gnu packages emacs)
	     (gnu packages wm)
	     (gnu packages version-control)
	     (gnu packages terminals)
	     (gnu packages xdisorg)
	     (gnu packages rust)
	     (gnu packages certs)
	     (gnu packages package-management)
	     (gnu packages fonts)
	     (gnu packages shells)
	     (gnu services desktop)
	     (gnu services xorg)
	     )

(use-service-modules networking ssh)
(use-package-modules screen gnome)

(operating-system
  (host-name "tareif-librem")
  (timezone "Asia/Riyadh")
  (locale "en_US.utf8")

  ;; Choose US English keyboard layout.  The "altgr-intl"
  ;; variant provides dead keys for accented characters.
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (target "/dev/sda")
                (keyboard-layout keyboard-layout)))

  (file-systems (cons (file-system
                         (device (file-system-label "my-root"))
                         (mount-point "/")
                         (type "ext4"))
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
		   sway
		   swaybg
		   swayidle
		   swaylock
		   waybar
		   rofi
		   alacritty
		   git
		   stow
		   rust
		   font-terminus
		   fish
		   nss-certs
		   %base-packages))

  (services (remove (lambda (service)
		      (eq? (service-kind service) gdm-service-type))
		    %desktop-services)))

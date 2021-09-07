(define %HOME (getenv "HOME"))
(define %GUIX_SD (string-append %HOME "/guix-sd"))

(system* "stow"
   (string-append "--dir="
      %GUIX_SD
      "/config")
   (string-append "--target=" %HOME)
   "--restow"
   "wallpapers"
   "guix"
   "shepherd"
   "git"
   "alacritty"
   "sway"
   "waybar"
   "rofi"
   "emacs")

;; we need to execute this for flatpak
;; sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

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
	 "alacritty"
	 "sway"
	 "waybar"
	 "rofi"
	 "emacs")

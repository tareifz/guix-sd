(define-module (tareifz home packages)
  #:use-module (gnu packages))

(define-public base-packages
  (map specification->package
       (list
        "alacritty"
        "emacs"
        "curl"
        "nss-certs"
        "sbcl"
        "git"
        "gnupg"
        "pinentry"
        "unzip"
        "intel-vaapi-driver"
        "libva-utils"
        "flatpak"
        "firefox")))

(define-public font-packages
  (map specification->package
       (list
        "fontconfig"
        "font-terminus"
        "font-awesome"
        "font-ghostscript"
        "font-dejavu"
        "font-gnu-freefont"
        ;; for Japan, China, Korea
        "font-adobe-source-han-sans"
        "font-wqy-zenhei"
        "font-fira-code")))
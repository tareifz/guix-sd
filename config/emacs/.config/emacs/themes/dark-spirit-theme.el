;;; dark-spirit-theme.el --- Tareifz dark theme

;;; Commentary:
;;  Tareifz dark theme


;;; Code:
(require 'autothemer)

(autothemer-deftheme
 dark-spirit "Tareifz theme."
 ((((class color) (min-colors #xFFFFFF)))

  ;; color palette
  (spirit-red "#e63946")
  (spirit-green "#8ac926")
  (spirit-blue "#404AFF")
  (spirit-white "#BBBBBB") ; #CAC4CE
  (spirit-dark "#000000" ) ;; "#1A1A1A"
  (spirit-dark-lighter1 "#121211")
  (spirit-dark-lighter2 "#3D3C3C")
  (spirit-yellow "#f9c74f")
  (spirit-darkyellow "#ffb700")
  (spirit-purple "#9067c6")
  (spirit-orange "#FF7B00")
  (spirit-pink "#F540FF"))

 ((default (:foreground spirit-white :background spirit-dark))
  (cursor (:background spirit-red))
  (link (:foreground spirit-blue :underline t))
  (link-visited (:foreground spirit-blue :underline) nil)

  (mode-line (:foreground spirit-dark :background spirit-purple :box nil))
  (mode-line-inactive (:foreground spirit-dark :background spirit-pink))
  (fringe (:background spirit-dark-lighter1))
  (linum (:background spirit-dark-lighter1))
  (line-number (:background spirit-dark-lighter1))
  (line-number-current-line (:background spirit-dark-lighter2))
  (hl-line (:background spirit-dark-lighter1))

  (region (:background spirit-yellow :foreground spirit-dark-lighter1 :distant-foreground spirit-dark))
  ;; Built-in
  (font-lock-builtin-face (:foreground spirit-white :bold t))
  (font-lock-constant-face (:foreground spirit-red))
  (font-lock-comment-face (:foreground spirit-dark-lighter2))
  (font-lock-function-name-face (:foreground spirit-pink))
  (font-lock-keyword-face (:foreground spirit-purple :bold t))
  (font-lock-string-face (:foreground spirit-pink))
  (font-lock-variable-name-face (:foreground spirit-pink))
  (font-lock-type-face (:foreground spirit-orange))
  (font-lock-warning-face (:foreground spirit-red :bold t))

  (show-paren-match (:background spirit-blue :foreground spirit-white))))

(provide-theme 'dark-spirit)

;; End:

;;; dark-spirit-theme.el ends here

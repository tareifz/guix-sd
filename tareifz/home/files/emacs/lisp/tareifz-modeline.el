;;; tareifz-modeline.el --- Tareifz modeline -*- lexical-binding: t -*-
;;
;; Copyright (C) 2023 Tareif Al-Zamil <root@tareifz.me>
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;;
;;

;;; Code:

(defgroup tareifz-modeline nil
  "Tareifz custom modeline."
  :group 'mode-line)

(defgroup tareifz-modeline-faces nil
  "Custom faces for the modeline."
  :group 'tareifz-modeline)

(defface tareifz-modeline-emacs-lisp
  '((((class color)) :background "purple" :foreground "white"))
  "Face for `emacs-lisp-mode'.")

(defface tareifz-modeline-clojure
  '((((class color)) :background "#91dc47" :foreground "#ffffff"))
  "Face for `Clojure-mode'.")

(defface tareifz-modeline-rust
  '((((class color)) :background "black" :foreground "white"))
  "Face for `rust-mode'.")

(defvar tareifz-modeline-major-mode-faces-list
  '((emacs-lisp-mode . tareifz-modeline-emacs-lisp)
    (clojure-mode . tareifz-modeline-clojure)
    (rust-mode . tareifz-modeline-rust)))

(defun tareifz-modeline-major-mode-name ()
  "Get `major-mode' name capitalized."
  (concat " " (capitalize (string-remove-suffix "-mode" (symbol-name major-mode))) " "))

(defun tareifz-modeline-major-mode ()
  "Major mode name with propertize."
  (let ((major-mode-name (tareifz-modeline-major-mode-name)))
    `(:eval (propertize ,major-mode-name 'face  ',(alist-get major-mode tareifz-modeline-major-mode-faces-list)))))

(setq-default mode-line-format
              '("%e"
                (:eval (tareifz-modeline-major-mode))
                " "
                "%l"                    ; line number
                "/"
                (:eval (number-to-string (car (buffer-line-statistics))))
                " %f"
                ))


(provide 'tareifz-modeline)

;;; tareifz-modeline.el ends here

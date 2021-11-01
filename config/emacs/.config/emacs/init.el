;; (require 'package)
;; (setq package-archives
;;       '(("gnu" . "https://elpa.gnu.org/packages/")
;;         ("melpa" . "https://melpa.org/packages/")))
;; (package-initialize)

;; (unless (package-installed-p 'use-package)
;;   (progn
;;     (package-refresh-contents)
;;     (package-install 'use-package)))

;; (require 'use-package)

;; (require 'bind-key)

;; (setq use-package-always-ensure t)

(setq user-full-name "Tareif Al-Zamil"
      user-mail-address "root@tareifz.me")

(setq-default highlight-tabs t)
(setq-default show-trailing-whitespace t)

(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

(defalias 'list-buffers 'ibuffer)

(delete-selection-mode 1)
(global-hl-line-mode 1)

(global-auto-revert-mode 1)

(setq-default indent-tabs-mode nil)

(setq-default tab-width 2)
(setq-default default-tab-width 2)

(setq-default tab-always-indent nil)

(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(defun tz/set-ui ()
  "Set UI settings (fonts, hide bars, ...)"
  (interactive)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1)
  ;; (set-frame-font "GohuFont:pixelsize=14")
  (set-face-attribute 'default nil :height 120))

(setq bookmark-save-flag 1)

(defun tareifz/load-only-theme ()
  "Disable all themes and then load a single theme interactively."
  (interactive)
  (while custom-enabled-themes
    (disable-theme (car custom-enabled-themes)))
  (call-interactively 'load-theme))

(defun tareifz/kill-line ()
  "Killing current line with the new line character, and put the cursor at the beginning of the line."
  (interactive)
  (let (line-begin line-end)
    (setq line-begin (line-beginning-position))
    (setq line-end (if (= (point-max) (line-end-position))
                       (progn
                         (line-end-position))
                     (progn
                       (forward-line 1)
                       (line-beginning-position))))
    (kill-region line-begin line-end)
    (beginning-of-line))
  )

(electric-pair-mode 1)

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame frame)
            (tz/set-ui)))

(tz/set-ui)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(electric-pair-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

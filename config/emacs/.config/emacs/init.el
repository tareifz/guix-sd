;;; package --- Summary

;;; Commentary:
;;; Tareifz Emacs config

(require 'package)

;;; Code:
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)

(require 'bind-key)

(setq use-package-always-ensure t)

(setq user-full-name "Tareif Al-Zamil"
      user-mail-address "root@tareifz.me")

;; ;; Load $PATH to emacs exec-path var
;; (use-package exec-path-from-shell
;;   :config
;;   (exec-path-from-shell-copy-env "DOCKER_APPS")
;;   (dolist (var '("DOCKER_APPS"))
;;   (add-to-list 'exec-path-from-shell-variables var)))

;; (when (daemonp)
;;   (exec-path-from-shell-initialize))

(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

(defalias 'list-buffers 'ibuffer)



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
  (set-face-attribute 'default nil :height 110))

(setq bookmark-save-flag 1)

(defun tz/load-only-theme ()
  "Disable all themes and then load a single theme interactively."
  (interactive)
  (while custom-enabled-themes
    (disable-theme (car custom-enabled-themes)))
  (call-interactively 'load-theme))

(defun tz/kill-line ()
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

(fset 'yes-or-no-p 'y-or-n-p)

(electric-pair-mode 1)
(show-paren-mode t)
(delete-selection-mode 1)
(global-hl-line-mode 1)
(global-auto-revert-mode 1)
(global-linum-mode t)

(setq-default linum-format " %d ")
(setq-default indent-tabs-mode nil)
(setq-default highlight-tabs t)
(setq-default show-trailing-whitespace t)
(setq-default tab-width 2)
(setq-default default-tab-width 2)
(setq-default tab-always-indent nil)
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

(setq-default js-indent-level 2)

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame frame)
            (tz/set-ui)))

(setq custom-theme-directory "~/.config/emacs/themes/")
(load-theme 'github t)

(tz/set-ui)

(setq-default custom-file "~/.config/emacs/auto-generated-customized-settings.el")
(when (not (file-exists-p custom-file))
  (with-temp-buffer (write-file custom-file)))

(load-file custom-file)


(bind-key* "C-k" 'tz/kill-line)

(defun insert-crystal-template()
  (when (= (point-max) (point-min))
    (insert-file-contents "~/.config/emacs/templates/crystal.cr")))

(add-hook 'crystal-mode-hook 'insert-crystal-template)

(use-package try)

(use-package rainbow-mode
  :hook
  (prog-mode . rainbow-mode))

(use-package rainbow-delimiters
  :requires rainbow-mode
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq lsp-completion-provider :capf)
  :custom
  (company-idle-delay 0.1)
  (company-tooltip-align-annotations t))

(use-package rust-mode)
(use-package typescript-mode)
(use-package crystal-mode)
(use-package fish-mode)
(use-package yaml-mode)
(use-package toml-mode)

(use-package multiple-cursors
  :bind
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

(use-package switch-window
  :bind
  ("C-x o" . switch-window))

(use-package which-key
  :config
  (which-key-mode)
  (which-key-setup-side-window-right-bottom))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :config
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(use-package flycheck-rust
  :requires (flycheck rust-mode)
  :hook
  (flycheck-mode . flycheck-rust-setup))

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package diff-hl
  :config
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode))

(use-package hl-todo
  :config
  (global-hl-todo-mode))

(use-package hlinum
  :config
  (hlinum-activate))

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(use-package yascroll
  :config
  (global-yascroll-bar-mode 1))

;; install -> yay rust-analyzer
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  ((rust-mode . lsp)
   (typescript-mode . lsp)
    (lsp-mode . lsp-enable-which-key-integration))
  :config
  (setq lsp-rust-server 'rust-analyzer)
  )

(use-package lsp-ui)

(use-package auto-package-update
  :config
  (auto-package-update-maybe))

(use-package restclient
  :config
    (add-to-list 'auto-mode-alist '("\\.restclient\\'" . restclient-mode)))

(use-package ivy
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  (ivy-mode 1))

(use-package counsel
  :config
  (counsel-mode))

(use-package highlight-thing
  :hook
  (prog-mode . highlight-thing-mode))

;;; init.el ends here

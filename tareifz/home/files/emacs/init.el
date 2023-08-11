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

(use-package emacs

  :config
  ;; General Emacs configs
  (setq user-full-name "Tareif Al-Zamil"
        user-mail-address "root@tareifz.me"
        inhibit-splash-screen 1
        initial-scratch-message nil
        initial-major-mode 'emacs-lisp-mode
        bookmark-save-flag 1
        make-backup-files nil
        backup-inhibited t
        auto-save-default nil)
  ;; Set UTF-8 encoding.
  (set-language-environment 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  ;; y or n
  (fset 'yes-or-no-p 'y-or-n-p)
  ;; use ibuffer
  (defalias 'list-buffers 'ibuffer)
  ;;
  (electric-pair-mode 1) ;; enable only for non-lisps
  (show-paren-mode t)
  (delete-selection-mode 1)
  (global-hl-line-mode 1)
  (global-auto-revert-mode 1)
  (global-display-line-numbers-mode 0)

  (add-to-list 'custom-theme-load-path "~/.config/emacs/themes")

  (setq-default linum-format " %d "
                ring-bell-function 'ignore
                indent-tabs-mode nil
                highlight-tabs t
                tab-width 2
                default-tab-width 2
                tab-always-indent nil
                ;; Javescript indent level
                js-indent-level 2
                ;; Custom settings file
                custom-file "~/.config/emacs/auto-generated-customized-settings.el")

  (add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace t)))

  (unless (file-exists-p custom-file)
    (with-temp-buffer (write-file custom-file)))
  (load-file custom-file)

  ;; Vertico configs??
  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  (setq read-extended-command-predicate
        #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t)
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; corfu
  (setq completion-cycle-threshold 3)
  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete)

  (when (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (select-frame frame)
                (tz/set-ui))))

  ;; Set the UI
  (tz/set-ui)
  :hook ((before-save . whitespace-cleanup)
         (before-save . (lambda () (delete-trailing-whitespace)))
         (crystal-mode . tz/insert-file-template)
         (clojure-mode . tz/insert-file-template)
         (emacs-lisp-mode . tz/insert-file-template))
  :preface
  (defun tz/set-ui ()
    "Set UI settings (fonts, hide bars, ...)"
    (interactive)
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (toggle-scroll-bar -1)
    ;; (load-theme 'modus-operandi)
    (set-frame-font "Fira Code SemiBold:style=SemiBold")
    (set-face-attribute 'default nil :height 160))

  (defun tz/load-only-theme ()
    "Disable all themes and then load a single theme interactively."
    (interactive)
    (while custom-enabled-themes
      (disable-theme (car custom-enabled-themes)))
    (call-interactively 'load-theme))

  (defun tz/insert-file-template ()
    "Insert template file into the current buffer based on `major-mode'
when the buffer is empty."
    (when (and (= (point-max) (point-min))
               (not (string= (buffer-name) "*scratch*")))
      (let* ((filename (buffer-name))
             (current-year (format-time-string "%Y"))
             (current-date (format-time-string "%Y-%m-%d"))
             (filename-without-extension (string-remove-suffix ".el" filename)))
        (insert-file-contents (concat "~/.config/emacs/templates/" (symbol-name major-mode)))
        (replace-regexp-in-region "<%filename%>" filename)
        (replace-regexp-in-region "<%current-year%>" current-year)
        (replace-regexp-in-region "<%current-date%>" current-date)
        (replace-regexp-in-region "<%filename-without-extention%>" filename-without-extension))))

  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args))))

(use-package diminish
  :config
  (diminish 'hi-lock-mode))

(use-package try)

(use-package rainbow-mode
  :diminish rainbow-mode
  :hook (prog-mode . rainbow-mode)
  :config
  (setq rainbow-x-colors nil))

(use-package rainbow-delimiters
  :requires rainbow-mode
  :hook (prog-mode . rainbow-delimiters-mode))

;; (use-package company
;;   :diminish company-mode
;;   :hook (prog-mode . company-mode)
;;   :config
;;   (setq lsp-completion-provider :capf)
;;   :custom
;;   (company-idle-delay 0.1)
;;   (company-tooltip-align-annotations t))

(use-package rust-mode)
(use-package typescript-mode)
(use-package crystal-mode)
(use-package fish-mode)
(use-package yaml-mode)
(use-package toml-mode)
(use-package clojure-mode)

(use-package eldoc
  :diminish eldoc-mode)

(use-package multiple-cursors
  :bind
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

(use-package switch-window
  :bind
  ("C-x o" . switch-window))

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode)
  (which-key-setup-side-window-right-bottom))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package flycheck
  :diminish flycheck-mode
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
  (setq lsp-rust-server 'rust-analyzer
        lsp-completion-enable-additional-text-edit nil))

(use-package lsp-ui)
(use-package lsp-java
  :hook (java-mode . lsp))
(use-package lsp-treemacs)
(use-package dap-mode
  :after lsp-mode
  :config (dap-auto-configure-mode))
(use-package dap-java :ensure nil)

(use-package auto-package-update
  :config
  (auto-package-update-maybe))

(use-package restclient
  :config
  (add-to-list 'auto-mode-alist '("\\.restclient\\'" . restclient-mode)))

;; (use-package ivy
;;   :diminish ivy-mode
;;   :config
;;   (setq ivy-use-virtual-buffers t)
;;   (setq ivy-count-format "(%d/%d) ")
;;   (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
;;   (ivy-mode 1))

(use-package counsel
  :diminish counsel-mode
  :config
  (counsel-mode))

(use-package highlight-thing
  :diminish highlight-thing-mode
  :hook
  (prog-mode . highlight-thing-mode))

(use-package aggressive-indent
  :hook
  (emacs-lisp-mode . aggressive-indent-mode)
  (lisp-mode . aggressive-indent-mode)
  (scheme-mode . aggressive-indent-mode)
  (sly-mode . aggressive-indent-mode))

;; (use-package ef-themes
;;   :config
;;   (load-theme 'ef-summer t))

(use-package base16-theme
  :config
  (load-theme 'base16-atelier-forest-light)
  ;; (load-theme 'base16-pop)
  )

(use-package sly
  :config
  (setq inferior-lisp-program "~/.guix-home/profile/bin/sbcl"))

(use-package sly-asdf)
(use-package sly-quicklisp)
;; expand macros in file C-c M-e
(use-package sly-macrostep)

(use-package cider)

(use-package paredit
  :hook
  (emacs-lisp-mode . paredit-mode)
  (lisp-mode . paredit-mode)
  (scheme-mode . paredit-mode)
  (clojure-mode . paredit-mode))

(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  (setq vertico-resize t)
  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t))

(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `global-corfu-modes'.
  :init
  (global-corfu-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;;; init.el ends here

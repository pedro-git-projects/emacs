(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)


;; Ensure package-list has been fetched
(when (not package-archive-contents)
  (package-refresh-contents))

;; We want to use use-package, not the default emacs behavior
(setq package-enable-at-startup nil)

;; Install use-package if it hasn't been installed
(when (not (package-installed-p 'use-package)) (package-install 'use-package))
(require 'use-package)

;; ido-mode provides a better file/buffer-selection interface
(use-package ido
             :ensure t
             :config (ido-mode t))
             
;; ido for M-x
(use-package smex
             :ensure t
             :config
             (progn
               (smex-initialize)
               (global-set-key (kbd "M-x") 'smex)
               (global-set-key (kbd "M-X") 'smex-major-mode-commands)
               ;; This is your old M-x.
               (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)))

;; Provides all the racket support
(use-package racket-mode
             :ensure t)

;; Clojure support
(unless (package-installed-p 'clojure-mode)
  (package-install 'clojure-mode))

;; slime
(unless (package-installed-p 'slime)
  (package-install 'slime))

;; Configure SBCL as the Lisp program for SLIME.
(add-to-list 'exec-path "/usr/local/bin")
(setq inferior-lisp-program "sbcl")

;; Syntax checking
(use-package flycheck
             :ensure t
             :config
             (global-flycheck-mode))

;; Autocomplete popups
(use-package company
             :ensure t
             :config
             (progn
               (setq company-idle-delay 0.2
                     ;; min prefix of 2 chars
                     company-minimum-prefix-length 2
                     company-selection-wrap-around t
                     company-show-numbers t
                     company-dabbrev-downcase nil
                     company-echo-delay 0
                     company-tooltip-limit 20
                     company-transformers '(company-sort-by-occurrence)
                     company-begin-commands '(self-insert-command)
                     )
               (global-company-mode))
             )
             
;; Lots of parenthesis and other delimiter niceties
(use-package paredit
             :ensure t
             :config
             (add-hook 'racket-mode-hook #'enable-paredit-mode))

;; Enable Paredit.
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(defun override-slime-del-key ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-del-key)

;; Colorizes delimiters so they can be told apart
(use-package rainbow-delimiters
             :ensure t
             :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
;; Make buffer names unique
;; buffernames that are foo<1>, foo<2> are hard to read. This makes them foo|dir  foo|otherdir
(use-package uniquify
             :config (setq uniquify-buffer-name-style 'post-forward))

;; Highlight matching parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Allows moving through wrapped lines as they appear
(setq line-move-visual t)

(setq inhibit-startup-message t) ;; hide splash screen on startup

(tool-bar-mode -1) ;; hide toolbar
(scroll-bar-mode -1) ;; hide scroll bar
(menu-bar-mode -1) ;; hide menu bar

(global-display-line-numbers-mode 1) ;; display lines
(setq display-line-numbers-type 'relative) ;; make lines relative

(load-theme 'gruvbox-dark-medium t) ;; set theme

(require 'evil) ;; extensible vi layer for Emacs
(evil-mode 1) ;; activate evil mode

;; Set default font
(set-face-attribute 'default nil
                    :family "Mononoki Nerd Font"
                    :height 140
                    :weight 'normal
                    :width 'normal)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



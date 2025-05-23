;;; setup-ui.el --- UI configuration module -*- lexical-binding: t; buffer-read-only: t; no-byte-compile: t -*-

;; Author: Nicolas CHAPON
;; Keywords: Emacs configuration
;; Homepage:

;;; Commentary:
;; Emacs config file.
;; This file was automatically generated by `org-babel-tangle'.
;; Do not change this file.  Main config is located in Readme.org at `user-emacs-directory'

;;; Code:

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq  inhibit-startup-message t)

(if (fboundp 'fringe-mode)
    (fringe-mode 2))

(use-package all-the-icons)

(use-package doom-themes

  :config

  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
  ;; may have their own settings.
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  ;;(doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (with-eval-after-load 'org-mode
      (doom-themes-org-config))
  )

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(defun nc/setup-font ()
  "Set up font height"
  (interactive)
  (when is-linux
    (set-frame-font "Jetbrains Mono 13" nil t))
  (when is-mac
    (if (> (display-pixel-width) 2500)
        (set-frame-font "Jetbrains Mono 16" nil t)
        (set-frame-font "Jetbrains Mono 14" nil t)))
  (when is-windows
    (set-frame-font "Jetbrains Mono 10" nil t))
  )

(when has-gui
  (add-hook 'after-init-hook #'nc/setup-font))

(setf use-default-font-for-symbols nil)
(set-fontset-font t 'unicode "Noto Emoji" nil 'append)

(use-package emojify
    :hook (after-init . global-emojify-mode)
    :config

    (set-fontset-font "fontset-default" 'symbol "Noto Color Emoji" nil 'append)
    (set-fontset-font "fontset-default" 'symbol "Symbola" nil 'append)
    (set-fontset-font t 'unicode (font-spec :family "all-the-icons") nil 'append)
    (set-fontset-font t 'unicode (font-spec :family "file-icons") nil 'append)
    (set-fontset-font t 'unicode (font-spec :family "Material Icons") nil 'append)
    (set-fontset-font t 'unicode (font-spec :family "github-octicons") nil 'append)
    (set-fontset-font t 'unicode (font-spec :family "FontAwesome") nil 'append)
    (set-fontset-font t 'unicode (font-spec :family "Weather Icons") nil 'append)

    ;; (add-hook 'markdown-mode-hook 'ac-emoji-setup)

    (require 'font-lock))

;; (use-package casual-editkit
;;       :ensure nil
;;       :bind (("<f2>" . casual-editkit-main-tmenu)))

(provide 'setup-ui)
;;; setup-ui.el ends here

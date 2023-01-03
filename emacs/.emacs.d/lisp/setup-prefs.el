;;; setup-prefs.el --- Global Preferences module -*- lexical-binding: t; buffer-read-only: t; no-byte-compile: t -*-

;; Author: Nicolas CHAPON
;; Keywords: Emacs configuration
;; Homepage:

;;; Commentary:
;; Emacs config file.
;; This file was automatically generated by `org-babel-tangle'.
;; Do not change this file.  Main config is located in Readme.org at `user-emacs-directory'

;;; Code:

(setq user-full-name "Nicolas Chapon"
        user-mail-address "nchapon@gmail.com")

(defconst is-mac (equal system-type 'darwin))
(defconst is-linux (equal system-type 'gnu/linux))
(defconst is-windows (equal system-type 'windows-nt))
(defconst has-gui (display-graphic-p))

(setq-default custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file t))

(setq initial-major-mode 'lisp-interaction-mode
      redisplay-dont-pause t
      column-number-mode t
      echo-keystrokes 0.02
      fill-column 80
      transient-mark-mode t
      shift-select-mode nil
      require-final-newline t
      truncate-partial-width-windows nil
      delete-by-moving-to-trash t
      confirm-nonexistent-file-or-buffer nil
      query-replace-highlight t
      ring-bell-function 'ignore
      sentence-end-double-space nil)

(auto-compression-mode t)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(define-key global-map (kbd "RET") 'newline-and-indent)

(prefer-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8-unix)
(setq coding-system-for-write 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8-unix)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
(setq file-name-coding-system  'utf-8)

(setq calendar-week-start-day 1
      calendar-day-name-array ["Dimanche" "Lundi" "Mardi" "Mercredi"
                               "Jeudi" "Vendredi" "Samedi"]
      calendar-month-name-array ["Janvier" "Fevrier" "Mars" "Avril" "Mai"
                                 "Juin" "Juillet" "Aout" "Septembre"
                                 "Octobre" "Novembre" "Decembre"])

(defvar french-holiday
  '((holiday-fixed 1 1 "Jour de l'an")
    (holiday-fixed 5 1 "Fête du travail")
    (holiday-fixed 5 8 "Victoire 45")
    (holiday-fixed 7 14 "Fête nationale")
    (holiday-fixed 8 15 "Assomption")
    (holiday-fixed 11 1 "Toussaint")
    (holiday-fixed 11 11 "Armistice 18")
    (holiday-fixed 12 25 "Noël")
    (holiday-easter-etc 1 "Lundi de Pâques")
    (holiday-easter-etc 39 "Ascension")
    (holiday-easter-etc 50 "Lundi de Pentecôte")))

(setq calendar-date-style 'european
      calendar-holidays french-holiday
      calendar-mark-holidays-flag t
      calendar-mark-diary-entries-flag t)

(when is-mac
  ;; Keys for Appel keyboard
  (setq mac-command-modifier 'meta)    ; make cmd key do Meta
  (setq mac-option-modifier 'super)    ; make opt key do Super
  (setq mac-control-modifier 'control) ; make Control key do Control
  (setq ns-function-modifier 'hyper)   ; make Fn key do Hyper

  (setq trash-directory "~/.Trash")    ; Trash Directory

  ;; Write Symbols [{}]
  (setq-default mac-right-option-modifier nil)

  ;; GPG
  (setf epa-pinentry-mode 'loopback)

  ;; Freench Locale
  (set-locale-environment "fr_FR.UTF-8"))

(use-package uniquify
  :straight nil
  :custom
  (uniquify-buffer-name-style 'forward)
  (uniquify-separator "/")
  (uniquify-after-kill-buffer-p t)
  (uniquify-ignore-buffers-re "^\\*")
)

(use-package recentf
  :straight nil
  :custom
  (recentf-auto-cleanup "09:00am")
  (recentf-max-saved-items 300)
  (recentf-exclude '((expand-file-name package-user-dir)
                     ".cache"
                     ".cask"
                     ".elfeed"
                     "bookmarks"
                     "cache"
                     "ido.*"
                     "persp-confs"
                     "recentf"
                     "undo-tree-hist"
                     "url"
                     "COMMIT_EDITMSG\\'")))

;; When buffer is closed, saves the cursor location
(save-place-mode 1)

(recentf-mode 1)

;; Set history-length longer
(setq-default history-length 500)

(bind-key "M-/" 'hippie-expand)

(provide 'setup-prefs)
;;; setup-prefs.el ends here

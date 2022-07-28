;;; setup-keys.el --- Key Bindings module -*- lexical-binding: t; buffer-read-only: t; no-byte-compile: t -*-

;; Author: Nicolas CHAPON
;; Keywords: Emacs configuration
;; Homepage:

;;; Commentary:
;; Emacs config file.
;; This file was automatically generated by `org-babel-tangle'.
;; Do not change this file.  Main config is located in Readme.org at `user-emacs-directory'

;;; Code:

;; Unbind unneeded keys
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "M-z") nil)
(global-set-key (kbd "C-x C-z") nil)
(global-set-key (kbd "M-o") nil)


(global-set-key (kbd "C-+") #'text-scale-increase)
(global-set-key (kbd "C--") #'text-scale-decrease)

;; Prefer backward-kill-word over Backspace
(global-set-key (kbd "C-w") #'backward-kill-word)
(global-set-key (kbd "C-x C-k") #'kill-region)

(global-set-key (kbd "C-x C-r") #'recentf-open-files)

;; Move up/down paragraph
(global-set-key (kbd "M-n") #'forward-paragraph)
(global-set-key (kbd "M-p") #'backward-paragraph)

;; Goto Line
;;(global-set-key (kbd "M-g") #'goto-line)

;; Functions
(global-set-key (kbd "<f5>") #'revert-buffer)

(defcustom nc-prefix "C-c C-SPC"
  "Prefix for all personal keybinds."
  :type 'string
  :group 'nc-emacs)

(bind-keys
   :prefix-map nc-map
   :prefix-docstring "Prefix for personal key bindings"
   :prefix nc-prefix
 ;; 2013-03-31: http://stackoverflow.com/questions/3124844/what-are-your-favorite-global-key-bindings-in-emacs
   ("C-e" . eshell-toggle)
   ("C-j" . nc/goto-journal-file)
   ("C-y" . consult-yasnippet)
   ("C-;" . nc/goto-emacs-config)
   ("M-j" . crux-top-join-line))

(bind-keys :prefix-map nc--insert-keys
           :prefix (concat nc-prefix " i")
           ("d" . nc/insert-date-stamp)
           ("p" . nc/generate-password)
           ("t" . nc/insert-time-slot)
           ("u" . nc/uuid)
           ("y" . consult-yasnippet)
           ("D" . nc/insert-date-stamp-inactive)             
           ("Y" . yankpad-insert))

(bind-keys :prefix-map nc--notes-keys
             :prefix (concat nc-prefix " n")
             ("d" . nc/org-insert-daily-review)
             ("h" . nc/insert-daily-heading)
             ("i" . nc/goto-inbox)
             ("j" . nc/goto-journal-file)
             ("p" . nc/goto-my-credentials)
             ("r" . nc/org-refile-subtree-to-file)
             ("N" . nc/goto-notes-dir)
             ("A" . nc/goto-archives-dir)
             ("T" . nc/goto-templates-dir)             
             ("t" . org-roam-buffer-toggle))

(bind-keys :prefix-map nc--search-keys
           :prefix (concat nc-prefix " s")
           ("n" . nc/search-notes))

(bind-keys :prefix-map nc--toggle-keys
             :prefix (concat nc-prefix " t")
             ("e" . eshell-toggle)
             ("v" . vterm-toggle)             
             ("t" . treemacs))

(use-package key-chord
  :init
  (key-chord-mode 1)
  (key-chord-define-global "FF" 'projectile-find-file)
  (key-chord-define-global "::" 'avy-goto-char-timer)
  (key-chord-define-global "GG" 'consult-ripgrep)
  (key-chord-define-global "OO" 'consult-outline)
  (key-chord-define-global "DD" 'delete-region)
  (key-chord-define-global "??" 'nc/search-notes)
  (key-chord-define-global "BB" 'beginning-of-buffer)
  (key-chord-define-global "$$" 'end-of-buffer))

(use-package which-key
  :diminish
  :custom
  (which-key-separator " ")
  (which-key-prefix-prefix "+")
  :config
  (which-key-mode))

(provide 'setup-keys)
;;; setup-keys.el ends here

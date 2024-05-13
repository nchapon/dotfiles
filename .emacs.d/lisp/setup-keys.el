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
(global-set-key (kbd "C-l") nil)
(global-set-key (kbd "M-z") nil)
(global-set-key (kbd "C-x C-z") nil)
(global-set-key (kbd "M-o") nil)
(global-set-key (kbd "M-SPC") nil)


(global-set-key (kbd "C-+") #'text-scale-increase)
(global-set-key (kbd "C--") #'text-scale-decrease)

;; Prefer backward-kill-word over Backspace
(global-set-key (kbd "C-w") #'backward-kill-word)
(global-set-key (kbd "C-x C-k") #'kill-region)

(global-set-key (kbd "C-x C-r") #'recentf-open-files)

;; Move up/down paragraph
(global-set-key (kbd "M-n") #'forward-paragraph)
(global-set-key (kbd "M-p") #'backward-paragraph)



;; Functions
(bind-keys
 ("<f5>" . revert-buffer)
 ("C-<f5>" . magit-log-buffer-file)
 ("<f6>" . treemacs)
 ("<f9>" . my/capture-interruption-task)
 ("<f11>" . nc/maximize-or-split-window-vertically)
 ("C-<f11>" . nc/split-window-horizontally)
 ("<f12>" . org-agenda)
 ("C-<f12>" . org-agenda))

;; Tools alt-[0-9]
(bind-keys
 ("M-0" . nc/maximize-or-split-window-vertically))

(use-package hydra
  :ensure t
  :custom
  (hydra-default-hint nil))

(use-package major-mode-hydra
  :ensure t)

;; Pretty Hydra
(use-package pretty-hydra
  :ensure t)

(pretty-hydra-define nc-hydra-insert (:foreign-keys warn :title "Insert" :quit-key "q" :exit t)
  ("Insert"
   (("d" nc/insert-datestamp-inactive "Date InActive")
    ("D" nc/insert-datestamp "Date Active")
    ("p" nc/generate-password "Password")
    ("u" nc/uuid "UUID"))

   "Snippet"
   (("y" consult-yasnippet "Yasnippet")
    ("Y" yankpad-insert "Yankpad"))))

(pretty-hydra-define nc-hydra-goto (:foreign-keys warn :title "Goto" :quit-key "q" :exit t)
  ("Configuration"
   ((";" nc/goto-emacs-config "Emacs Config"))

    "Personal Files"
    (("i" nc/goto-inbox "Inbox")
     ("p" nc/goto-my-credentials "Passwords"))

   "Personal Dirs"
   (("A" nc/goto-archives-dir "Archives")
    ("N" nc/goto-notes-dir "Notes")
    ("P" nc/goto-projects-dir "Projects")
    ("T" nc/goto-templates-dir "Templates"))))

(pretty-hydra-define nc-hydra-toggle
  (:color amaranth :quit-key "q" :title "Toggles")
  ("Basic"
   (("n" linum-mode "line number" :toggle t)
    ("w" whitespace-mode "whitespace" :toggle t)
    ;;("W" whitespace-cleanup-mode "whitespace cleanup" :toggle t)
    ("r" rainbow-mode "rainbow" :toggle t))
   "Highlight"
   (("l" hl-line-mode "line" :toggle t))
   "Coding"
   (("p" smartparens-mode "smartparens" :toggle t)
    ("P" smartparens-strict-mode "smartparens strict" :toggle t)
    ("S" show-smartparens-mode "show smartparens" :toggle t)
    ("e" eldoc-mode "eldoc" :toggle t))
   "Emacs"
   (("D" toggle-debug-on-error "debug on error" :toggle (default-value 'debug-on-error))
    ("X" toggle-debug-on-quit "debug on quit" :toggle (default-value 'debug-on-quit)))))

(pretty-hydra-define nc-hydra-windows
    (:color amaranth :quit-key "q" :title "Windows" :exit t)
    ("Move"
     (("v" nc/maximize-or-split-window-vertically "Maximize or Split Window V")
      ("h" nc/split-window-horizontally "Split Window H"))))

(major-mode-hydra-define org-mode nil
  ("GTD"
   (("s" nc/org-insert-daily-review "Start Daily Review")
    ("d" nc/insert-daily-heading "Insert Daily Heading"))
   "Actions"
   (("r" nc/org-refile-subtree-to-file "Refile subtree to file")
    ("A" nc/create-buffer-attachment-directory "Create attachment directory"))
   "Search"
   (("?" nc/search-notes "Search Notes"))))

(bind-keys
 ;; 2013-03-31: http://stackoverflow.com/questions/3124844/what-are-your-favorite-global-key-bindings-in-emacs
   ("C-c C-h" . major-mode-hydra) 
   ("C-c i" . nc-hydra-insert/body)
   ("C-c g" . nc-hydra-goto/body)
   ("C-c t" . nc-hydra-toggle/body)
   ("C-c w" . nc-hydra-windows/body))

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
  (key-chord-define-global "JJ" 'crux-top-join-line)
  (key-chord-define-global "MM" 'nc/maximize-or-split-window-vertically)
  (key-chord-define-global "$$" 'end-of-buffer))

(use-package which-key
  :diminish
  :custom
  (which-key-separator " ")
  (which-key-prefix-prefix "+")
  :config
  (which-key-mode)
  (which-key-enable-god-mode-support))

(provide 'setup-keys)
;;; setup-keys.el ends here

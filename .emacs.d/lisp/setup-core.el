;;; setup-core.el --- Core packages configuration file -*- lexical-binding: t; buffer-read-only: t; no-byte-compile: t -*-

;; Author: Nicolas CHAPON
;; Keywords: Emacs configuration
;; Homepage:

;;; Commentary:
;; Emacs config file.
;; This file was automatically generated by `org-babel-tangle'.
;; Do not change this file.  Main config is located in Readme.org at `user-emacs-directory'

;;; Code:

(use-package avy
  :defer t
  :custom
  (avy-timeout-seconds 0.5)
  (avy-style 'pre)
  (avy-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l ?m))
  :bind
  (("C-:" . avy-goto-subword-1)
   ("s-j"   . avy-goto-char-timer))     ; start / opt 
  :custom-face
  (avy-lead-face ((t (:background "#51afef" :foreground "#870000" :weight bold)))))

(use-package crux
  :bind
  (("C-a" . crux-move-beginning-of-line)
   ("C-c d" . crux-duplicate-current-line-or-region)
   ("C-x 4 t" . crux-transpose-windows)
   ("C-x K" . crux-kill-other-buffers)
   ("C-k" . crux-smart-kill-line)
   ("M-j" . crux-top-join-line))
  :config
  (crux-with-region-or-buffer indent-region)
  (crux-with-region-or-buffer untabify)
  (crux-with-region-or-point-to-eol kill-ring-save)
  (defalias 'rename-file-and-buffer #'crux-rename-file-and-buffer))

(use-package dired
  :straight nil
  :bind
  (("C-x C-j" . dired-jump)
   (:map dired-mode-map
              ("E" . wdired-change-to-wdired-mode)))
  :custom
  ;; Always delete and copy recursively
  (dired-recursive-deletes 'always)
  (dired-recursive-copies 'always)
  ;; Auto refresh Dired, but be quiet about it
  (global-auto-revert-non-file-buffers t)
  (auto-revert-verbose nil)
  ;; Quickly copy/move file in Dired
  (dired-dwim-target t)
  ;; Move files to trash when deleting
  (delete-by-moving-to-trash t)
  ;; Load the newest version of a file
  (load-prefer-newer t)
  ;; Detect external file changes and auto refresh file
  (auto-revert-use-notify nil)
  (auto-revert-interval 3) ; Auto revert every 3 sec


  :config
  ;; Enable global auto-revert
  (global-auto-revert-mode t)

  (put 'dired-find-alternate-file 'disabled nil)
  ;; Using GNU ls on macOS instead of ls
  (if (executable-find "gls")
      (progn
        (setq insert-directory-program "gls")
        (setq dired-listing-switches "-lFaGh1v --group-directories-first"))
    (setq dired-listing-switches "-ahlF"))


  ;; From https://www.emacs.dyerdwelling.family/emacs/20230606213531-emacs--dired-duplicate-here-revisited/
  (defun nc/dired-duplicate-file (arg)
    "Duplicate the current file in Dired."
    (interactive "p")
    (let ((filename (dired-get-filename)))
      (setq target (concat (file-name-sans-extension filename)
                           "-old"
                           (if (> arg 1) (number-to-string arg))
                           (file-name-extension filename t)))
      (if (file-directory-p filename)
          (copy-directory filename target)
        (copy-file filename target))
      )
    )

  (define-key dired-mode-map (kbd "C-c d") 'nc/dired-duplicate-file)


  :hook
  (dired-mode . (lambda ()
                  (local-set-key (kbd "<mouse-2>") #'dired-find-alternate-file)
                  (local-set-key (kbd "RET") #'dired-find-alternate-file)
                  (local-set-key (kbd "^")
                                 (lambda () (interactive) (find-alternate-file ".."))))))

(use-package dired-narrow
  :commands dired-narrow
  :after dired
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))

(use-package diredfl
  :init (diredfl-global-mode 1))

(use-package projectile
  :custom
  (projectile-sort-order 'recently-active)
  :config
  (projectile-global-mode)
  :init
    (setq projectile-enable-caching t)
    ;; Custom mode line
    (setq projectile-mode-line '(:eval (format " Ⓟ[%s]" (projectile-project-name))))
  :bind-keymap ("C-<f6>" . projectile-command-map))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package multiple-cursors
  :bind
  (("C-S-c C-S-c" .  mc/edit-lines)
   ("C-$" .  mc/edit-ends-of-lines)
   ("C-S-b" .  mc/edit-beginnings-of-lines)
   ;; Conflict my own map
   ;("C-<" .  mc/mark-previous-word-like-this) 
   ;("C->" .  mc/mark-next-word-like-this)
   ("C-S-n" .  mc/mark-next-like-this)
   ("C-S-p" .  mc/mark-previous-like-this)
   ("C-*" .  mc/mark-all-dwim)))

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/var/undo")))
    (setq undo-tree-visualizer-diff t)))

(use-package ediff
  :straight nil
  :custom
   ;; Ediff should be opened in selected frame and split window horizontally
  (ediff-window-setup-function 'ediff-setup-windows-plain)
  (ediff-split-window-function 'split-window-horizontally)
  (ediff-diff-options "-w")
  :config
  ;; Pour éviter des ouvertures de frames intempestives
  (advice-add 'ediff-window-display-p :override 'ignore))

(use-package magit

  :init
  (when (getenv "GIT_EXECUTABLE")
    (setq magit-git-executable (getenv "GIT_EXECUTABLE")))
  :commands (magit-status magit-get-current-branch)

  :bind ("C-x g" . magit-status))

(use-package treemacs
  :ensure t
  :bind (:map global-map
              ("M-à" . treemacs-select-window)
              ("M-0" . treemacs-select-window)
              ("C-x t t" . treemacs)
              ("C-x t 1" . treemacs-delete-other-windows))
  :custom
  (treemacs-is-never-other-window t)
  (treemacs-persist-file (expand-file-name ".cache/treemacs-persist" user-emacs-directory))
  :hook
  (treemacs-mode . treemacs-project-follow-mode))

;; (use-package treemacs-projectile
;;   :after (treemacs projectile)
;;   :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package rainbow-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode)
  (diminish 'rainbow-mode))

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config
  (use-package yasnippet-snippets)
  :hook
  (after-init . yas-global-mode))

(use-package consult-yasnippet
  :bind
  (:map global-map
   ("C-c y" . consult-yasnippet)))

(defun +yas/org-src-header-p ()
    "Determine whether `point' is within a src-block header or header-args."
    (pcase (org-element-type (org-element-context))
      ('src-block (< (point) ; before code part of the src-block
                     (save-excursion (goto-char (org-element-property :begin (org-element-context)))
                                     (forward-line 1)
                                     (point))))
      ('inline-src-block (< (point) ; before code part of the inline-src-block
                            (save-excursion (goto-char (org-element-property :begin (org-element-context)))
                                            (search-forward "]{")
                                            (point))))
      ('keyword (string-match-p "^header-args" (org-element-property :value (org-element-context))))))


  (defun +yas/org-prompt-header-arg (arg question values)
  "Prompt the user to set ARG header property to one of VALUES with QUESTION.
The default value is identified and indicated. If either default is selected,
or no selection is made: nil is returned."
  (let* ((src-block-p (not (looking-back "^#\\+property:[ \t]+header-args:.*" (line-beginning-position))))
         (default
           (or
            (cdr (assoc arg
                        (if src-block-p
                            (nth 2 (org-babel-get-src-block-info t))
                          (org-babel-merge-params
                           org-babel-default-header-args
                           (let ((lang-headers
                                  (intern (concat "org-babel-default-header-args:"
                                                  (+yas/org-src-lang)))))
                             (when (boundp lang-headers) (eval lang-headers t)))))))
            ""))
         default-value)
    (setq values (mapcar
                  (lambda (value)
                    (if (string-match-p (regexp-quote value) default)
                        (setq default-value
                              (concat value " "
                                      (propertize "(default)" 'face 'font-lock-doc-face)))
                      value))
                  values))
    (let ((selection (consult--read values :prompt question :default default-value)))
      (unless (or (string-match-p "(default)$" selection)
                  (string= "" selection))
        selection))))

(use-package emojify
  :hook (after-init . global-emojify-mode))

(provide 'setup-core)
;;; setup-core.el ends here

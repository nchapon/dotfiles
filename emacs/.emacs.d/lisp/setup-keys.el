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

(bind-keys
 :prefix-map nc-map
 :prefix-docstring "My own keyboard map"
 :prefix "C-<"
 ;; 2013-03-31: http://stackoverflow.com/questions/3124844/what-are-your-favorite-global-key-bindings-in-emacs
 (";" . nc/goto-emacs-config)
 ("<tab>" . expand-abbrev))

(use-package key-chord
  :init
  (key-chord-mode 1)
  (key-chord-define-global "FF" 'projectile-find-file)
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

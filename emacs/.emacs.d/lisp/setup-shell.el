(use-package vterm
  :commands vterm
  :custom
  (vterm-disable-bold-font t)
  (vterm-disable-inverse-video nil)
  (vterm-disable-underline nil)
  (vterm-kill-buffer-on-exit t)
  (vterm-max-scrollback 9999)
  (vterm-shell "/bin/zsh")
  (vterm-term-environment-variable "xterm-256color"))

(use-package vterm-toggle
  :custom
  ;; Show Vterm Buffer in bottom side
  (vterm-toggle-fullscreen-p nil)
  :init
  (add-to-list 'display-buffer-alist
               '((lambda(bufname _) (with-current-buffer bufname (equal major-mode 'vterm-mode)))
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (side . bottom)
                 (dedicated . t) ;dedicated is supported in emacs27
                 (reusable-frames . visible)
                 (window-height . 0.3)))
  :bind
  (:map nc-map
        ("$" . vterm-toggle)
        :map vterm-mode-map
        ("C-<return>" . vterm-toggle-insert-cd)
        ("C-S-n" . vterm-toggle-forward)
        ("C-S-p" . vterm-toggle-backward)
        ))

(use-package aweshell
  :straight (aweshell
             :type git
             :host github
             :repo "manateelazycat/aweshell")
  :custom
  (eshell-highlight-prompt nil)
  (eshell-prompt-function 'epe-theme-dakrone)

  :bind
  (:map nc-map
        ("C-e" . aweshell-dedicated-toggle)))

(provide 'setup-shell)
;;; setup-shell.el ends here

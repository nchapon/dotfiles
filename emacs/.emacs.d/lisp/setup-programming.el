;;; setup-programming.el --- Programming configuration module -*- lexical-binding: t; buffer-read-only: t; no-byte-compile: t -*-

;; Author: Nicolas CHAPON
;; Keywords: Emacs configuration
;; Homepage:

;;; Commentary:
;; Emacs config file.
;; This file was automatically generated by `org-babel-tangle'.
;; Do not change this file.  Main config is located in Readme.org at `user-emacs-directory'

;;; Code:

(use-package lsp-mode
  :commands lsp
  :bind-keymap ("C-< l" . lsp-command-map)
  :hook (lsp-mode . (lambda ()
                      (let ((lsp-keymap-prefix "C-< l"))
                        (lsp-enable-which-key-integration))))
  :config
  (setq ; recommended
        gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024))

  (setq ; optional
        ;; lsp-clojure-custom-server-command '("/Users/nchapon/_PIM/tmp/2del/clojure-lsp") 

        ; Features
        lsp-lens-enable t
        lsp-semantic-tokens-enable t

        ;; Conflicts with other Clojure emacs packages
        cljr-add-ns-to-blank-clj-files nil ; disable clj-refactor adding ns to blank files
        cider-eldoc-display-for-symbol-at-point nil ; disable cider eldoc integration
        ; lsp-eldoc-enable-hover nil ; disable lsp-mode showing eldoc during symbol at point
        ; lsp-enable-indentation nil ; uncomment to use cider indentation instead of lsp
        ; lsp-enable-completion-at-point nil ; uncomment to use cider completion instead of lsp
        ))

;; optionally
(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-position 'top
        lsp-ui-doc-alignment 'window))

(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(defun lsp-save-hooks () "Install save hooks for lsp."
       (add-hook 'before-save-hook #'lsp-format-buffer t t)
       (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package smartparens
  :defer t
  :diminish ""
  :hook (((clojure-mode
           emacs-lisp-mode
           common-lisp-mode
           scheme-mode
           lisp-mode
           cider-repl-mode
           inferior-lisp-mode
           inferior-emacs-lisp-mode)
          . smartparens-strict-mode)
         (prog-mode . smartparens-mode))

  :bind (:map smartparens-mode-map
              ("C-M-q" . sp-indent-defun)
              :map smartparens-strict-mode-map
              (";" . sp-comment))

  :config
  (require 'smartparens-config)
  (sp-use-paredit-bindings)
  (define-key smartparens-mode-map (kbd "M-r") 'sp-rewrap-sexp) ; needs to be set manually, because :bind section runs before config
  (setq smartparens-strict-mode t)
  (sp-local-pair 'emacs-lisp-mode "`" nil :when '(sp-in-string-p))

  (defun nc--create-newline-and-enter-sexp (&rest _ignored)
    "Open a new brace or bracket expression, with relevant newlines and indent. "
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode))

  (sp-with-modes '(c-mode c++-mode js-mode js2-mode java-mode
                          typescript-mode perl-mode)
    (sp-local-pair "{" nil :post-handlers
                   '((nc--create-newline-and-enter-sexp "RET")))))

(use-package paren
  :straight nil
  :hook (prog-mode . show-paren-mode)
  :custom
  (show-paren-delay 0)
  (show-paren-when-point-in-periphery t))

(use-package clojure-mode
  :hook
  ((clojure-mode . lsp)
   (clojurec-mode . lsp)
   (clojurescript-mode . lsp)
   (clojure-mode . lsp-save-hooks))
  :init
  (setq clojure-align-forms-automatically t))

(use-package cider
  :init
  (setq org-babel-clojure-backend 'cider))

(use-package dockerfile-mode
  :mode "Dockerfile.*\\'")

(use-package lua-mode
  :mode "\\.lua\\'")

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :config

  (setq markdown-fontify-code-blocks-natively t)

  ;; Process Markdown with Pandoc, using GitHub stylesheet for nice output
  (let ((stylesheet (expand-file-name
                     (locate-user-emacs-file "etc/pandoc.css"))))
    (setq markdown-command
          (mapconcat #'shell-quote-argument
                     `("pandoc" "--toc" "--section-divs"
                       "--css" ,(concat "file://" stylesheet)
                       "--standalone" "-f" "markdown" "-t" "html5")
                     " "))))


(use-package markdown-toc
  :after markdown-mode)

(use-package python-mode
  :straight nil
  :mode ("\\.py\\'")
  :custom
  (python-shell-interpreter "python3"))

(use-package restclient
  :mode (("\\.restclient\\'" . restclient-mode)
         ("\\.http\\'" . restclient-mode)))

(use-package web-mode
  :mode (("\\.html\\'" . web-mode)
         ("\\.hbs\\'" . web-mode)
         ("\\.tag$" . web-mode)
         ("\\.ftl$" . web-mode)
         ("\\.jsp$" . web-mode)
         ("\\.php$" . web-mode))
  :config
  (add-hook 'web-mode-hook (lambda ()
                             (setq web-mode-markup-indent-offset 4)
                             (setq web-mode-code-indent-offset 4))))

(use-package js2-mode
  :mode "\\.js\\'"
  :init
  (defalias 'javascript-generic-mode 'js2-mode)
  :config
  (js2-imenu-extras-setup)
  (setq-default js-auto-indent-flag nil
                js2-strict-missing-semi-warning nil
                js-indent-level 2)

  ;; Don't override global M-j keybinding (join lines)
  (define-key js2-mode-map (kbd "M-j") nil))

(use-package yaml-mode
  :mode (("\\.yaml\\'" . yaml-mode)
           ("\\.yml\\'" . yaml-mode))
  :custom
  (yaml-indent-offset 4))

(provide 'setup-programming)
;;; setup-programming.el ends here

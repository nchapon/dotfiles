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
  :bind
  (:map lsp-mode-map
        ( ;;("C-\M-b" . lsp-find-implementation)
         ("M-RET" . lsp-execute-code-action)))
  :hook (lsp-mode . lsp-enable-which-key-integration)
  :config
  (setq ; recommended
   gc-cons-threshold (* 100 1024 1024)
   read-process-output-max (* 1024 1024))

  (setq ; optional
   ;; lsp-clojure-custom-server-command '("/Users/nchapon/_PIM/tmp/2del/clojure-lsp") 

                                        ; Features
   lsp-lens-enable t
                                        ;lsp-semantic-tokens-enable t

   lsp-headerline-breadcrumb-enable nil ;; disable breadcrumb


   ;; Conflicts with other Clojure emacs packages
   cljr-add-ns-to-blank-clj-files nil ; disable clj-refactor adding ns to blank files
   cider-eldoc-display-for-symbol-at-point nil ; disable cider eldoc integration
                                        ; lsp-eldoc-enable-hover nil ; disable lsp-mode showing eldoc during symbol at point
                                        ; lsp-enable-indentation nil ; uncomment to use cider indentation instead of lsp
                                        ; lsp-enable-completion-at-point nil ; uncomment to use cider completion instead of lsp

   ;; Terraform
   lsp-disabled-clients '(tfls)

   ))

;; optionally
(use-package lsp-ui
  :hook lsp-mode
  :init
  ;; (setq lsp-ui-doc-alignment 'frame
  ;;       lsp-ui-doc-position  'bottom
  ;;       lsp-ui-doc-use-childframe nil)
  :config
  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; @see https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil))
  :bind (:map lsp-ui-mode-map
              (([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
               ([remap xref-find-references] . lsp-ui-peek-find-references))))

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list)

(defun lsp-save-hooks () "Install save hooks for lsp."
       (add-hook 'before-save-hook #'lsp-format-buffer t t)
       (add-hook 'before-save-hook #'lsp-organize-imports t t))

(defhydra hydra-lsp (:exit t :hint nil)
    "
   Buffer^^               Server^^                   Symbol
  -------------------------------------------------------------------------------------
   [_f_] format           [_M-r_] restart            [_d_] definition   [_i_] implementation  [_o_] documentation
   [_m_] imenu            [_S_]   shutdown           [_D_] declaration  [_t_] type            [_r_] rename
   [_x_] execute action   [_M-s_] describe session   [_R_] references   [_s_] signature"
    ("d" lsp-ui-peek-find-definitions)
    ("D" lsp-find-declaration)
    ("R" lsp-ui-peek-find-references)
    ("i" lsp-ui-peek-find-implementation)
    ("t" lsp-find-type-definition)
    ("s" lsp-signature-help)
    ("o" lsp-describe-thing-at-point)
    ("r" lsp-rename)

    ("f" lsp-format-buffer)
    ("m" lsp-ui-imenu)
    ("x" lsp-execute-code-action)

    ("M-s" lsp-describe-session)
    ("M-r" lsp-restart-workspace)
    ("S" lsp-shutdown-workspace))
(global-set-key (kbd "C-l") 'hydra-lsp/body)

(use-package flycheck
  :hook ((lsp-mode . flycheck-mode))
  :init
  (setq flycheck-indication-mode 'right-fringe)
  ;; only check on save
  (setq flycheck-check-syntax-automatically '(mode-enabled save)))

(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  ;; :custom
  ;; (lsp-enable-dap-auto-configure nil)
  ;; :config
  ;; (dap-ui-mode 1)
  :commands dap-debug
  :config
  (require 'dap-hydra)

  ;; Bind `C-c l d` to `dap-hydra` for easy access
   


  )

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
  ;; Unbind sp-convolute-xexp (conflict with xref-find-references / lsp-ui-peek-find-references)
  (unbind-key "M-?" smartparens-mode-map)

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

(use-package devdocs
  :bind ("C-h D" . devdocs-lookup))

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
  (setq org-babel-clojure-backend 'cider)
  :bind ([remap cider-pprint-eval-last-sexp] . cider-pprint-eval-last-sexp-to-comment))

(use-package dockerfile-mode
  :mode "Dockerfile.*\\'")

(use-package go-mode)

(use-package just-mode)

(use-package lua-mode
  :mode "\\.lua\\'")

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :config

  (setq markdown-live-preview-delete-export 'delete-on-destroy)
  (setq markdown-fontify-code-blocks-natively t)
  (setq markdown-split-window-direction 'right)
  ;; Process Markdown with Pandoc, using GitHub stylesheet for nice output
  (let ((stylesheet (expand-file-name
                     (locate-user-emacs-file "etc/pandoc.css"))))
    (setq markdown-command
          (concat "pandoc --toc --section-divs"
                  " --css   file://" stylesheet
                  " --standalone -f markdown -t html5"
                     )))
  )

(use-package markdown-toc
  :after markdown-mode)

;; Render Markdwon with GitHub API
(use-package gh-md
  :after markdown-mode
  :bind 
  (:map markdown-mode-map
        ([remap markdown-preview] . gh-md-render-buffer)))

(use-package plantuml-mode
  :init
  (setq plantuml-default-exec-mode 'jar)
  (setq plantuml-jar-path (expand-file-name "~/opt/plantuml.jar"))
  (setq org-plantuml-jar-path (expand-file-name "~/opt/plantuml.jar"))
  ;; (setq org-startup-with-inline-images t)
  ;; (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  ;; (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
  :mode "\\.puml\\'"
  :bind
  (:map plantuml-mode-map
        ("C-c C-p" . nc/plantuml-generate-png))
  :config
  (setq plantuml-output-type "png")
  (defun nc/plantuml-generate-png ()
    (interactive)
    (when (buffer-modified-p)
      (error "There are unsaved changes!!!"))
    (let* ((input (expand-file-name (buffer-file-name)))
           (output (concat (file-name-sans-extension input) ".png"))
           (output-buffer (get-file-buffer output)))
      (message (format "Rendering %s" input))
      (call-process "java" nil t nil
                    ;; the jar file...
                    "-jar"
                    (expand-file-name plantuml-jar-path)
                    "-charset" "UTF-8"
                    input
                    "-tpng")
      (if output-buffer
          (with-current-buffer output-buffer
            (revert-buffer-quick)
            (pop-to-buffer output-buffer))
        (find-file-other-window output)))))

(use-package python-mode
  :straight nil
  :mode ("\\.py\\'")
  :hook ((python-mode . dap-ui-mode)
         (python-mode . dap-mode)
         (python-mode . lsp-deferred))
  :custom
  (python-shell-interpreter "python3")


  :config
  (require 'dap-python)
  (setq dap-python-debugger 'debugpy))

(use-package lsp-pyright
  :init
  (setq lsp-pyright-typechecking-mode "basic") ;; too much noise in "real" projects
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

(use-package conda
  :when (executable-find "conda")
  :config
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (add-to-list
     'global-mode-string
     '(:eval
       (list
        (if conda-env-current-name
            (propertize (concat "(py: " conda-env-current-name ") ")
                        'face 'font-lock-builtin-face
                        'help-echo "Conda environment"
                        'mouse-face '(:box 1)
                        'local-map (make-mode-line-mouse-map
                                    'mouse-1
                                    (lambda () (interactive)
                                      (conda-env-activate))))
          "")))))

(use-package virtualenvwrapper
  :ensure t
  :init
  (venv-initialize-eshell))

(use-package pyvenv
  :config
  (pyvenv-mode))

(use-package apheleia
  :config
  (add-to-list 'apheleia-mode-alist '(python-mode . ruff))
  :bind
  (("C-c f" . apheleia-format-buffer)))

(use-package python-pytest
  :straight '(python-pytest :host github :repo "nchapon/emacs-python-pytest")
  :config
  (setq python-pytest-executable "python -m pytest")
  :bind
  (:map python-mode-map
          ("C-c C-t a" . python-pytest)
          ([remap python-skeleton-try] . python-pytest-function-dwim)
          ("C-c C-t T" . python-pytest-function)
          ([remap python-skeleton-for] . python-pytest-file-dwim)
          ("C-c C-t F" . python-pytest-file)
          ([remap python-skeleton-def] . python-pytest-dispatch)
          ("C-c C-t r" . python-pytest-repeat)
          ("C-c C-t x" . python-pytest-last-failed)))

(use-package terraform-mode
  :hook ((terraform-mode . lsp)))

(use-package restclient
  :mode (("\\.restclient\\'" . restclient-mode)
         ("\\.http\\'" . restclient-mode))

  :bind
  ("<f4>" . nc/restclient-open-collection)
  (:map restclient-mode-map
        ("C-c r" . rename-buffer)
        ("C-c h" . nc/restclient-toggle-headers))
  :hook
  (restclient-mode-hook . nc/restclient-imenu-index)
  :config
  (defun nc/restclient-toggle-headers ()
    (interactive)
    (message "restclient-response-body-only=%s"
             (setf restclient-response-body-only
                   (not restclient-response-body-only))))
  (defun nc/restclient-open-collection (&optional arg)
    "Open a file from the restclient \"collection\".
Use prefix ARG to open the file in another window."
    (interactive "P")
    (let ((restclient-file (read-file-name "Open restclient file:"
                                           (concat (getenv "PIM_HOME") "/notes/restclient/")
                                           nil
                                           nil
                                           nil
                                           (lambda (name)
                                             (string-equal
                                              (file-name-extension name)
                                              "http")))))
      (if arg
          (find-file-other-window restclient-file)
        (find-file restclient-file))))
  (defun nc/restclient-imenu-index ()
    "Configure imenu on the convention \"### Title\"."
    (setq-local imenu-generic-expression '((nil "^### \\(.*\\)$" 1)))))

(use-package verb
  :config
  (setq verb-auto-kill-response-buffers 2) ; Two mots recent buffers for response

  )

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

(use-package web-mode
  :mode (("\\.html\\'" . web-mode)
         ("\\.hbs\\'" . web-mode)
         ("\\.tag$" . web-mode)
         ("\\.ftl$" . web-mode)
         ("\\.jsp$" . web-mode)
         ("\\.vue$" . web-mode)
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

;;; setup-programming.el --- Programming configuration module -*- lexical-binding: t; buffer-read-only: t; no-byte-compile: t -*-

;; Author: Nicolas CHAPON
;; Keywords: Emacs configuration
;; Homepage:

;;; Commentary:
;; Emacs config file.
;; This file was automatically generated by `org-babel-tangle'.
;; Do not change this file.  Main config is located in Readme.org at `user-emacs-directory'

;;; Code:

(use-package compile
  :defer t
  :hook ((compilation-filter . ansi-color-compilation-filter))
  :config
  (setopt compilation-scroll-output t)
  (setopt compilation-ask-about-save nil)
  (require 'ansi-color))

(use-package lsp-mode
  :commands lsp
  :bind
  (:map lsp-mode-map
        ( ;;("C-\M-b" . lsp-find-implementation)
         ("M-RET" . lsp-execute-code-action)))
  :bind-keymap ("C-c l" . lsp-command-map)
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

   lsp-completion-provider :none

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

  (setq lsp-ui-imenu-window-fix-width 40)
  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; @see https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil))
  :bind (:map lsp-ui-mode-map
              (([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
               ([remap xref-find-references] . lsp-ui-peek-find-references))))

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list)


;; Integration with consult
(use-package consult-lsp)

(with-eval-after-load 'lsp-mode
  ;; Remap `lsp-treemacs-errors-list' (bound to C-c l g e).
  (define-key lsp-mode-map
              [remap lsp-treemacs-errors-list]
              #'consult-lsp-diagnostics)

  ;; Remap `xref-find-apropos' (bound to C-c l g a).
  (define-key lsp-mode-map
              [remap xref-find-apropos]
              #'consult-lsp-symbols))

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

;; -*- lexical-binding: t; -*-
(use-package treesit
  :straight (:type built-in)
  :mode ("\\.tsx\\'" . tsx-ts-mode)
  :config
  (setq treesit-language-source-alist
        '((bash "https://github.com/tree-sitter/tree-sitter-bash")
          (cmake "https://github.com/uyha/tree-sitter-cmake")
          (css "https://github.com/tree-sitter/tree-sitter-css")
          (elisp "https://github.com/Wilfred/tree-sitter-elisp")
          (go "https://github.com/tree-sitter/tree-sitter-go")
          (html "https://github.com/tree-sitter/tree-sitter-html")
          (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
          (json "https://github.com/tree-sitter/tree-sitter-json")
          (make "https://github.com/alemuller/tree-sitter-make")
          (markdown "https://github.com/ikatyang/tree-sitter-markdown")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (ruby "https://github.com/tree-sitter/tree-sitter-ruby")
          (rust "https://github.com/tree-sitter/tree-sitter-rust")
          (toml "https://github.com/tree-sitter/tree-sitter-toml")
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src")
          (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src")
          (yaml "https://github.com/ikatyang/tree-sitter-yaml")
          (astro "https://github.com/virchau13/tree-sitter-astro")
          (sql "https://github.com/DerekStride/tree-sitter-sql" "gh-pages" "src")
          (hcl "https://github.com/tree-sitter-grammars/tree-sitter-hcl")))

  (defun treesit-install-all-grammars ()
    (interactive)
    (dolist (lang (mapcar #'car treesit-language-source-alist))
      (treesit-install-language-grammar lang)))

  (defvar treesit-langs-mode-overrides '((sh-mode . bash)
                                         (sh-ts-mode . bash)
                                         (css-mode . css)
                                         (emacs-lisp-mode . elisp)
                                         (emacs-lisp-ts-mode . elisp)
                                         (js-mode . javascript)
                                         (js-ts-mode . javascript)
                                         (json-mode . json)
                                         (makefile-mode . make)
                                         (makefile-ts-mode . make)))

  (defun treesit-parse-lang-from-mode (mode)
    (let* ((mode (if (symbolp mode) (symbol-name mode) mode))
           (lang (save-match-data
                   (string-match "\\(.*?\\)\\(-ts\\)?-mode" mode)
                   (match-string 1 mode))))
      (intern lang)))

  (defun treesit-lang-for-mode (mode)
    (or (cdr (assoc mode treesit-langs-mode-overrides))
        (treesit-parse-lang-from-mode mode)
        (error "Unable to determine tree-sitter parser for %s" mode)))

  (defun treesit-parser ()
    (if-let ((lang (treesit-lang-for-mode major-mode)))
        (treesit-parser-create lang (current-buffer))
      (user-error "No tree-sitter parser for %s" major-mode)))

  (defun treesit-node-start-line-number (node)
    (when-let ((start (treesit-node-start node)))
      (line-number-at-pos start)))

  (defun treesit-surrounding-method-call-named (name)
    (treesit-parent-until
     (treesit-node-at (point) (treesit-parser))
     (lambda (n)
       (and
        (equal (treesit-node-type n) "call")
        (equal
         (treesit-node-text
          (treesit-node-child-by-field-name n "method"))
         name)))
     t))

  (defun treesit-rspec-all-calls-named (type)
    (let* ((parser (treesit-parser))
           (root (treesit-parser-root-node parser)))
      (->> (treesit-query-capture
            root
            `((call
               method: (identifier) @id
               (:equal @id ,type)
               arguments: (argument_list (string (string_content)))
               block: (_)) @node))
           (-filter (lambda (n) (eq (car n) 'node)))
           (-map #'cdr))))

  (defun treesit-rspec-all-examples ()
    (treesit-rspec-all-calls-named "it"))

  (defun treesit-rspec-all-example-groups ()
    (treesit-rspec-all-calls-named "describe"))

  (defun treesit-rspec-all-contexts ()
    (treesit-rspec-all-calls-named "context"))

  (defun treesit-rspec-example-at-point ()
    (treesit-surrounding-method-call-named "it"))

  (defun treesit-rspec-context-at-point ()
    (treesit-surrounding-method-call-named "context"))

  (defun treesit-rspec-example-group-at-point ()
    (treesit-surrounding-method-call-named "describe"))

  (defun treesit-rspec-method-name (node)
    (when-let ((args (treesit-node-child-by-field-name node "arguments")))
      (->> (treesit-query-capture args '((string (string_content) @name)))
           (-filter (lambda (n) (eq (car n) 'name)))
           (-map #'cdr)
           (-mapcat (lambda (n) (treesit-node-text n t)))))))

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

;; From https://www.jamescherti.com/emacs-markdown-table-of-contents-update-before-save/
;; The following functions and hooks guarantee that any existing table of
;; contents remains current whenever changes are made to the markdown file,
;; while also ensuring that both the window start and cursor position remain
;; unchanged.
(defun nc/markdown-toc-gen-if-present ()
  "Generate a table of contents if it is already present."
  (let ((marker (point-marker))
        (current-visual-line
         (save-excursion
           (beginning-of-visual-line)
           (count-screen-lines (window-start) (point)))))
    (unwind-protect
        (when (markdown-toc--toc-already-present-p)
          (markdown-toc-generate-toc))
      (progn
        (goto-char (marker-position marker))
        (when (> current-visual-line 0)
          (let ((window-start (save-excursion
                                (beginning-of-visual-line)
                                (let ((line-move-visual t)
                                      (line-move-ignore-invisible nil))
                                  (line-move (* -1 current-visual-line)))
                                (beginning-of-visual-line)
                                (point))))
            (set-window-start (selected-window) window-start)))))))

(defun nc/setup-markdown-toc ()
  "Setup the markdown-toc package."
  (add-hook 'before-save-hook #'nc/markdown-toc-gen-if-present nil t))

(add-hook 'markdown-mode-hook #'nc/setup-markdown-toc)
;; (add-hook 'markdown-ts-mode-hook #'my-setup-markdown-toc)
;; (add-hook 'gfm-mode-hook #'my-setup-markdown-toc)


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


(defun nc/plantuml-preview-current-block (prefix)
  "PlantUML preview current block (hack windows to byPass the pb preview)"
  (interactive "P")
  (when is-windows
    (let* ((image-buffer-name "plantuml-preview.png")
           (preview-file (concat "~/Documents/" image-buffer-name)))
      (when (file-exists-p preview-file)
        (delete-file preview-file))

      (plantuml-preview-current-block 1)
      (when (buffer-live-p (get-buffer image-buffer-name))
        (set-buffer image-buffer-name)
        (set-buffer-modified-p nil)
        (kill-this-buffer))
      
      (with-current-buffer (get-buffer "*PLANTUML Preview*")
        (write-file preview-file)
        (set-buffer image-buffer-name)
        (save-buffer)
        (image-mode))))
  (when is-mac
    (plantuml-preview-current-block 1))
  (when is-linux
    (plantuml-preview-current-block 1)))

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


(defun pyvenv-activate-poetry ()
  "Activate the venv created by Poetry."
  (interactive)
  (let ((default-directory (project-root (project-current)))
        (path (string-trim
               (shell-command-to-string "env -u VIRTUAL_ENV poetry env info --path"))))
    (pyvenv-activate path)
    (message "project: %s\nactivated: %s" default-directory path)))

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

(use-package python-insert-docstring
  :bind
  (:map python-mode-map
        ("C-c i" . python-insert-docstring-with-google-style-at-point)))

(use-package terraform-mode
  :hook ((terraform-mode . lsp)))

(use-package verb
  :config
  (setq verb-auto-kill-response-buffers nil) ; Response buffers killed before sending a request.

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

(use-package yaml-ts-mode
  :mode ("\\.yaml\\'" "\\.yml\\'")
  :config
  (add-hook 'yaml-ts-mode-hook #'highlight-indent-guides-mode))

(use-package yaml-pro
  :hook (yaml-ts-mode . yaml-pro-ts-mode)
  :config
  (defun yaml-pro-edit-initialize-buffer-filter-args-advice (args)
    (if-let ((mode (language-detection-detect-mode (buffer-string))))
        (cl-destructuring-bind (parent-buffer buffer initial-text type initialize path) args
          (let ((init-func (lambda ()
                             (funcall mode)
                             (when initialize
                               (call-interactively initialize)))))
            (list parent-buffer buffer initial-text type init-func path)))
      args))
  (advice-add 'yaml-pro-edit-initialize-buffer :filter-args #'yaml-pro-edit-initialize-buffer-filter-args-advice)

  :bind
    (:map yaml-pro-ts-mode-map
          ("C-c j" . yaml-pro-ts-move-subtree-down)
          ("C-c k" . yaml-pro-ts-move-subtree-up)
          ("C-c f" . yaml-pro-format)))

(provide 'setup-programming)
;;; setup-programming.el ends here

(add-to-list 'load-path "~/.emacs.d")

;; Add Marmalade package archive for Emacs starter kit and other Emacs packages

(require 'package)
(add-to-list 'package-archives
'("marmalade" . "http://marmalade-repo.org/packages/") )
(package-initialize)


;; Add Clojure and other supporting packages to the Emacs environment
;; Packages are installed if they are not already present
;; The list includes packages for the starter kit, Clojure and markdown files (used by github)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-eshell starter-kit-bindings
clojure-mode clojure-test-mode remember
        rainbow-delimiters
        ac-slime popup
markdown-mode ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;Autocomplete mode
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
;(require 'auto-complete-config)
;(ac-config-default)

;; Org Configuration
;; Org Agenda


; Org agenda config
(setq org-agenda-files (list "~/notes/GTD/perso.org"
                             "~/notes/GTD/valtech.org"
                             "~/notes/GTD/toread.org"
                             "~/notes/GTD/tolearn.org"
                             "~/notes/valtech/missions/tinubu/notes.org"
                             ))


(setq org-agenda-start-on-weekday nil) ;Start agenda on current day

(setq org-todo-keywords
       '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)" )))

(setq org-todo-keyword-faces
           '(("TODO" . org-warning) ("INPROGRESS" . "orange") ("WAITING" . "cyan")
             ("CANCELED" . (:foreground "grey" :weight bold))))


(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Capture mode
;;(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/notes/GTD/perso.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("v" "Todo Valtech" entry (file+headline "~/notes/GTD/valtech.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("l" "To learn" entry (file+headline "~/notes/GTD/tolearn.org" "To Learn")
         "* TO_LEARN %?\n  %i\n  %a")
        ("r" "To read" entry (file+headline "~/notes/GTD/toread.org" "To Read")
         "* TO_READ %?\n  %i\n  %a")
        ("f" "FishLog" plain (file+datetree+prompt "~/notes/private/fishlog.org")
         "%[~/notes/templates/fishlog.org]"
         )
        ("j" "Journal" entry (file+datetree "~/notes/GTD/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a"))
)
;; Diary
(setq org-agenda-include-diary t)

;; Publish
(require 'org-publish)
(setq org-publish-project-alist
      '(

       ;; ... add all the components here (see below)...

        ("org-notes"
         :base-directory "~/notes/"
         :base-extension "org"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         :style "<link rel=\"stylesheet\" title=\"Standard\" href=\"/home/nchapon/public_html/style/worg.css\" type=\"text/css\" />"
         :section-numbers nil
	 :table-of-contents nil
         )
        
         ;; These are static files (images, pdf, etc)
	 ("org-static"
	        :base-directory "~/notes/" ;; Change this to your local dir
		:base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|txt\\|asc"
		:publishing-directory "~/public_html/"
	        :recursive t
		:publishing-function org-publish-attachment
	 )

	    ("org" :components ("org-notes" "org-static"))
	 )

        
   )






;; Clojure development

;; Launch the Clojure repl via Leiningen - M-x clojure-jack-in
;; Global shortcut definition to fire up clojure repl and connect to it

(global-set-key (kbd "C-c C-j") 'clojure-jack-in)


;; Colour mach parens and other structure characters to make code easy to follow

(global-rainbow-delimiters-mode)

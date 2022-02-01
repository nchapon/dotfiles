;;; setup-org.el --- Org mode configuration file -*- lexical-binding: t; buffer-read-only: t; no-byte-compile: t -*-

;; Author: Nicolas CHAPON
;; Keywords: Emacs configuration
;; Homepage:

;;; Commentary:
;; Emacs config file.
;; This file was automatically generated by `org-babel-tangle'.
;; Do not change this file.  Main config is located in Readme.org at `user-emacs-directory'

;;; Code:

(use-package org

  :bind (("C-c l" . org-store-link)
         ("C-c c" . org-capture)
         ("C-c a" . org-agenda)
         ("<f12>" . org-agenda)
         ("C-c C-b" . org-iswitchb))

  :config
  ;; New template exapnsion
  (require 'org-tempo)

  (setq org-ellipsis " ⬎"
        org-cycle-separator-lines 0                 ;; Hide empty lines between subtrees
        org-catch-invisible-edits 'show-and-error   ;; Avoid inadvertent text edit in invisible area
        )

  (set-face-attribute 'org-ellipsis nil :underline nil)

  ;; Autamatically add =ID= (unique identifier) in heading drawers to keep links unique
  (require 'org-id)
  (setq org-id-method 'uuidgen)
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)

  (require 'org-crypt)
  (org-crypt-use-before-save-magic)

  (add-to-list 'org-tags-exclude-from-inheritance "crypt")
  ;; GPG key to use for encryption
  ;; Either the Key ID or set to nil to use symmetric encryption.
  (setq org-crypt-key "0DF2D6C6E8443FE7"))

  (use-package org-contrib)

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :after org
  :custom (org-bullets-bullet-list '("◉" "✿" "★" "•")))

;; Hiding leading bullets in headers
(setq org-hide-leading-stars t)

(let* ((variable-tuple (cond ((x-list-fonts "Input Sans") '(:font "Input Sans"))
                             ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                             ((x-list-fonts "Verdana")         '(:font "Verdana"))
                             ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                             (nil (warn "Cannot find a Sans Serif Font.  Install Open Sans."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight normal :foreground ,base-font-color)))

  (custom-theme-set-faces 'user
                          '(org-special-keyword  ((t (:inherit (font-lock-comment-face fixed-pitch)) :foreground "#69ffeb")))

                          `(org-level-8 ((t (,@headline ,@variable-tuple))))
                          `(org-level-7 ((t (,@headline ,@variable-tuple))))
                          `(org-level-6 ((t (,@headline ,@variable-tuple))))
                          `(org-level-5 ((t (,@headline ,@variable-tuple))))
                          `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
                          `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.2 :foreground "#ff8a69"))))
                          `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.3 :foreground "#ffd569"))))
                          `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5 :foreground "#ffaf69"))))
                          `(org-document-title ((t (,@headline ,@variable-tuple :height 1.8 :underline nil :foreground "#e6b68d"))))
                          `(org-document-info         ((t (:foreground "#697dff"))))
                          `(org-document-info-keyword         ((t (:foreground "#697dff"))))
                          `(header-line ((t (:background "#697dff" :height 220))))
                          '(org-special-keyword-face ((t (:foreground "#697dff"))))

                          '(org-block-begin-line ((t (:foreground "#69ffeb"))))
                          '(org-verbatim ((t (:foreground "#69ffeb"))))
                          '(org-table ((t (:foreground "#fae196"))))
                          `(org-checkbox ((t (:foreground "#ff4c4f"
                                         :box (:line-width 1 :style released-button)))))
                          `(org-date ((t (:foreground "#69ffeb"))))
                          `(org-tag ((t (:foreground "#e6b68d"))))

                          `(org-checkbox-statistics-todo ((t (:foreground "#ff4c4f"))))
                          '(org-list-dt               ((t (:foreground "#ff4c4f"))))
                          '(org-link                  ((t (:foreground "#697dff" :underline t))))))

(use-package org-fancy-priorities
      :diminish
      :defines org-fancy-priorities-list
      :hook (org-mode . org-fancy-priorities-mode)
      :config (setq org-fancy-priorities-list '("⚡" "⬆" "⬆" "⬇")))

(setq org-lowest-priority ?D
        org-default-priority ?D
        org-priority-faces '((?A . (:foreground "red" :weight bold))
                             (?B . (:foreground "orange"))
                             (?C . (:foreground "yellow"))
                             (?D . (:foreground "green"))))

(setq org-startup-indented t
      org-pretty-entities t
      ;; show actually italicized text instead of /italicized text/
      org-hide-emphasis-markers t
      org-fontify-quote-and-verse-blocks t)

(use-package org
  :custom
  (org-directory "~/notes")
  :config

  (defconst nc/org-default-projects-dir (concat org-directory "/projects"))
  (defconst nc/org-default-projects-file (concat org-directory "/projects.org"))
  (defconst nc/org-default-resources-dir (concat org-directory "/resources"))
  (defconst nc/org-default-archives-dir (concat org-directory "/archives"))
  (defconst nc/org-default-personal-dir (concat org-directory "/personal"))
  (defconst nc/org-default-completed-dir (concat org-directory "/projects/_completed"))
  (defconst nc/org-journal-dir (concat org-directory "/journal"))
  (defconst nc/inbox-file (concat org-directory "/gtd.org"))
  (defconst nc/org-default-inbox-file (concat org-directory "/gtd.org"))
  (defconst nc/org-default-tasks-file (concat org-directory "/gtd.org"))
  (defconst nc/watching-file (concat org-directory "/personal/watching.org"))
  (defconst nc/reading-file (concat org-directory "/personal/books.org"))
  (defconst nc/org-default-media-files (concat org-directory "/personal/watching.org"))
  (defconst nc/org-default-someday-file (concat org-directory "/someday.org"))
  (defconst nc/fishing-file (concat org-directory "/personal/sports/fishing.org"))
  (defconst nc/calendar-file (concat org-directory "/personal/calendar.org"))
  (defconst nc/weekly-review-file (concat org-directory "/personal/reviews/weekly-review.org"))


  (defun nc/goto-inbox ()
    (interactive)
    (find-file nc/inbox-file )
    (widen)
    (beginning-of-buffer)
    (re-search-forward "* Inbox")
    (beginning-of-line))

  (bind-key "gi" 'nc/goto-inbox nc-map)


  (defun nc/goto-resources-dir ()
    (interactive)
    (dired nc/org-default-resources-dir))

  (bind-key "gR" 'nc/goto-resources-dir nc-map)

  (defun nc/goto-archives-dir ()
    (interactive)
    (dired nc/org-default-archives-dir))

  (bind-key "gA" 'nc/goto-archives-dir nc-map)

)

(defun nc/goto-journal-file ()
      "Create and load a journal file based on today's date."
      (interactive)

      (find-file (nc--get-journal-file-today)))

(defun nc--get-journal-file-today ()
      "Return today's journal file."
      (let ((daily-name (format-time-string "%Y-W%W")))
        (expand-file-name (concat nc/org-journal-dir "/" daily-name ".org"))))

(setq org-default-notes-file (nc--get-journal-file-today))

(bind-key "gj" 'nc/goto-journal-file nc-map)
(bind-key "j" 'nc/goto-journal-file nc-map)

(defun nc--autoinsert-yas-expand ()
      "Replace text in yasnippet template."
      (yas-expand-snippet (buffer-string) (point-min) (point-max)))

    (setq auto-insert 'other
          auto-insert-directory (concat org-directory "/templates"))

    (define-auto-insert "\\.org\\'" ["week.org" nc--autoinsert-yas-expand])


  (defun nc/journal-file-insert ()
    "Insert's the journal heading based on the file's name."
    (interactive)
    (let* ((datim (current-time)))

      (insert (format-time-string (concat "%A %d %B %Y") datim))


      ;; Note: The `insert-file-contents' leaves the cursor at the
      ;; beginning, so the easiest approach is to insert these files
      ;; in reverse order:

      ;; If the journal entry I'm creating matches today's date:

        ;; Insert dailies that only happen once a week:
        (let ((weekday-template (downcase
                                 (format-time-string "templates/journal-%A.org"))))
          (when (file-exists-p weekday-template)
            (insert-file-contents weekday-template)))

        (insert "\n")

        ;; (let ((contents (buffer-string)))
        ;;   (delete-region (point-min) (point-max))
        ;;   (yas-expand-snippet contents (point-min) (point-max)))

        ))

(defun nc/insert-daily-heading ()
  "Insert Daily Heading in journal file"
  (interactive)
  (let ( (header-title (format-time-string "%Y-W%W" )))
    ;; Don't change location of point.
    (goto-char (point-min)) ;; From the beginning...
    (if (search-forward header-title)
        ;;(end-of-line)
        (progn
          (org-insert-heading-after-current)
          (nc/journal-file-insert)
          (org-shiftmetaright))
      (error "Insert failed"))))

;; bind-key
 (bind-key "od" 'nc/insert-daily-heading nc-map)

(setq org-todo-keywords
 '((sequence "TODO(t)" "NEXT(n)" "SOMEDAY(.)" "MAYBE(M)"  "|" "DONE(d)")
   (sequence "STARTED(s)" "WAITING(w@/!)" "|" "CANCELLED(c@/!)" "INACTIVE(i@)")
   (sequence "MEETING(m)" "RDV(r)"  "|" "DONE(d)")))

(setq org-log-done 'time)

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "#c0392b" :weight bold)
              ("NEXT" :foreground "#d35400" :weight bold)
              ("STARTED" :foreground "#f39c12" :weight bold)
              ("SOMEDAY" :foreground "#3498db" :weight bold)
              ("DONE" :foreground "#27ae60" :weight bold)
              ("WAITING" :foreground "#e74c3c" :weight bold)
              ("INACTIVE" :foreground "#bdc3c7" :weight bold)
              ("MEETING" :foreground "#e6b68d" :weight bold)
              ("RDV" :foreground "#e6b68d" :weight bold)
              ("MAYBE" :foreground "#3498db" :weight bold)
              ("CANCELLED" :foreground "#7f8c8d" :weight bold))))

(setq org-tag-alist (quote ((:startgroup)
                            ("@office" . ?o)
                            ("@home" . ?h)
                            (:endgroup)
                            ("@computer" . ?c)
                            ("@reading" . ?r)
                            ("learning" . ?l)
                            ("emacs" . ?e)
                            (:newline)
                            ("WAITING" . ?w)
                            ("HOLD" . ?H)
                            ("CANCELLED" . ?c))))

;;(setq org-fast-tag-selection-single-key nil)

(setq org-tags-exclude-from-inheritance '("project")
      org-stuck-projects '("+project/-DONE"
                           ("TODO" "NEXT") ()))

(setq org-capture-templates
        '(("t" "Task Entry"        entry
              (file+headline nc/inbox-file "Inbox")
              "* TODO %?\n:PROPERTIES:\n:CREATED:%U\n:END:\n\n%i\n\nFrom: %a"
              :empty-lines 1)
          ("s" "Someday" entry (file+headline nc/inbox-file "Inbox")
            "* SOMEDAY %? :idea:\n%u" :clock-in t :clock-resume t)
          ("f" "FishLog" plain (file+datetree+prompt nc/fishing-file)
           "%[~/notes/templates/fishlog.org]")
          ("F" "Film" entry (file+headline nc/watching-file "Films à voir")
               "* NEXT %^{Titre}
       %i
       - *Réalisateur:* %^{Auteur}
       - *Année:* %^{année}
       - *Genre:* %^{genre}

      %?

      %U" :prepend t)


           ("D" "Done Business Task" entry
             (file+headline nc/inbox-file "Tasks")
             "* DONE %^{Task} :@office:"
             :clock-in t :clock-resume t)
          ))

(add-to-list 'org-capture-templates
                 `("m" "Meeting" entry (file+headline nc/calendar-file "Réunions")
           "* MEETING %? :meeting:\n%U\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n"))

(add-to-list 'org-capture-templates
                 `("a" "RendezVous" entry (file+headline nc/calendar-file "RendezVous")
                 "* RDV %? :rdv:\n%U\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n"))

(defun org-journal-find-bookmark ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (nc/goto-journal-file)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.

  (goto-char (point-min))
  (search-forward (concat "Links " (format-time-string "%Y-W%W"))))

(add-to-list 'org-capture-templates
               `("l" "Linkk" entry (function org-journal-find-bookmark)
                      "* %?\n  %i\n  From: %a" :empty-lines 1))

(add-to-list 'org-capture-templates
                 '("n" "Note"  entry
                   (file+headline nc/inbox-file "Notes")
                   "* %(org-insert-time-stamp nil nil t) %?\n  %i \n  See: %a" :empty-lines 1))

(add-to-list 'org-capture-templates
                 '("b" "Book"  entry
                   (file+headline nc/reading-file "Inbox")
                   "* NEXT %^{Title}\n:PROPERTIES:\n:author: %^{Author}\n:name: %^{Title}\n:END:\n\n%i\n\n" :empty-lines 1))

(add-to-list 'org-capture-templates
             `("i" "Interrupting task" entry
               (function org-journal-find-location)
               "* %^{Task}"
               :clock-in t :clock-resume t))

(defun my/capture-interruption-task ()
    "Interrupted Task"
    (interactive)
    (org-capture 4 "i"))

;; Override the key definition
(global-set-key (kbd "<f9>") 'my/capture-interruption-task)

(add-to-list 'org-capture-templates
                   `("p" "New Project" entry (file nc/org-default-projects-file)
             (file "~/notes/templates/newproject.org")))

(defun org-journal-find-location ()
 ;; Open today's journal, but specify a non-nil prefix argument in order to
 ;; inhibit inserting the heading; org-capture will insert the heading.
 (nc/goto-journal-file)
 ;; Position point on the journal's top-level heading so that org-capture
 ;; will add the new entry as a child entry.

 (goto-char (point-min)))

(add-to-list 'org-capture-templates
               `("d" "Review: Daily Review" entry (function org-journal-find-location)
                 (file "~/notes/templates/dailyreview.org")
                 :clock-in t :clock-resume t))

(defun nc/org-insert-daily-review ()
  "Insert daily review in org file"
  (interactive)
  (progn
    (org-capture nil "d")
    (org-capture-finalize t)
    (org-narrow-to-subtree)
    (org-clock-in)))

(bind-key "oD" 'nc/org-insert-daily-review nc-map)

(add-to-list 'org-capture-templates
                 `("w" "WeeklyReview" entry (file+datetree+prompt nc/weekly-review-file)
           "* Summary of the week :REVIEW:\n%[~/notes/templates/review.org]"))

(setq org-agenda-file-regexp "\\`[^.].*\\.org\\'\\|[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]$"
        org-agenda-files (list "~/notes/gtd.org" "~/notes/projects.org" "~/notes/someday.org" "~/notes/personal/calendar.org" "~/notes/journal/")
        org-agenda-span 'day
        org-agenda-start-on-weekday nil
        org-agenda-skip-deadline-if-done t
        org-agenda-skip-scheduled-if-done t
        org-agenda-start-with-log-mode t
        org-agenda-block-separator nil
        org-deadline-warning-days 5)

(setq diary-file "~/notes/diary"
      org-agenda-include-diary t)

(defun nc--org-agenda-skip-project ()
    (org-agenda-skip-entry-if 'regexp ":project:"))

(defun nc--org-agenda-format-parent (n)
  ;; (s-truncate n (org-format-outline-path (org-get-outline-path)))
  (save-excursion
    (save-restriction
      (widen)
      (org-up-heading-safe)
      (s-truncate n (org-get-heading t t)))))

(defun org-current-is-todo ()
  (string= "NEXT" (org-get-todo-state)))

(defun org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))

(require 'org-agenda)

(setq org-agenda-custom-commands
      '(("," "Agenda"
               ((agenda "" ((org-agenda-sorting-strategy '(timestamp-up time-up priority-down category-keep))))

                (tags-todo "TODO=\"STARTED\"+|TODO=\"WAITING\""
                           ((org-agenda-overriding-header "Started / waiting tasks")
                            (org-agenda-prefix-format " %i %-25:c")
                            ;;(org-agenda-prefix-format "%-27:(nc--org-agenda-format-parent 25)")
                            (org-agenda-sorting-strategy '(priority-down todo-state-up category-keep))))
                ;; (tags-todo "TODO=\"NEXT\"+@office-HOLD"
                ;;            ((org-agenda-overriding-header "Next tasks @office")
                ;;             (org-tags-exclude-from-inheritance '("project"))
                ;;             (org-agenda-prefix-format "%-27:(nc--org-agenda-format-parent 25)")
                ;;             ;; (org-agenda-skip-function
                ;;             ;;  (quote
                ;;             ;;   (org-agenda-skip-all-siblings-but-first)))
                ;;             (org-agenda-sorting-strategy '(priority-down todo-state-up category-keep))
                ;;             (org-agenda-todo-keyword-format "%-4s")))
                (tags-todo "TODO=\"NEXT\""
                           ((org-agenda-overriding-header "Next tasks")
                            (org-agenda-prefix-format " %i %-25:c")
                            (org-agenda-skip
                             '(org-agenda-skip-if 'scheduled 'deadline))
                            ;;(org-agenda-files '("~/_PIM/notes/gtd.org"))
                            (org-agenda-sorting-strategy '(priority-down todo-state-up category-keep))))
                )
               nil)
        ("g" . "GTD contexts")
           ("go" "Office" tags-todo "@office")
           ("gc" "Computer" tags-todo "@computer")
           ("ge" "Emacs" tags-todo "emacs")
           ("gl" "Learning" tags-todo "learning")
           ("gr" "Reading" tags-todo "@reading")
            ;; exports block to this file with C-c a e
          ;; ..other commands here
        ("p" "Projects" tags "project")
           ))

(defun nc/org-agenda-recent-open-loops ()
    (interactive)
    (let ((org-agenda-start-with-log-mode t)
            (org-agenda-use-time-grid nil))
      ;; (fetch-calendar)
      (org-agenda-list nil (org-read-date nil nil "-2d") 4)))

(use-package org
  :bind (("C-c C-x C-i" . nc/org-clock-in)
         ("C-c C-x C-o" . org-clock-out)
         ("<f11>" . org-clock-goto))
  :config
  (progn
    ;; Insinuate it everywhere
    (org-clock-persistence-insinuate)
    ;; Show lot of clocking history so it's easy to pick items off the C-F11 list
    (setq org-clock-history-length 23
          ;; Resume clocking task on clock-in if the clock is open
          org-clock-in-resume t
          ;; Separate drawers for clocking and logs
          org-drawers '("PROPERTIES" "CLOCK" "LOGBOOK" "RESULTS" "HIDDEN")
          ;; Save clock data and state changes and notes in the LOGBOOK drawer
          org-clock-into-drawer t
          ;; Sometimes I change tasks I'm clocking quickly -
          ;; this removes clocked tasks with 0:00 duration
          org-clock-out-remove-zero-time-clocks t
          ;; Clock out when moving task to a done state
          org-clock-out-when-done t
          ;; Save the running clock and all clock history when exiting Emacs, load it on startup
          org-clock-persist t
          ;; Prompt to resume an active clock
          org-clock-persist-query-resume t
          ;; Enable auto clock resolution for finding open clocks
          org-clock-auto-clock-resolution #'when-no-clock-is-running
          ;; Include current clocking task in clock reports
          org-clock-report-include-clocking-task t)))

(defun nc--org-clocktable-indent-string (level)
  (if (= level 1)
      ""
    (let ((str "\\"))
      (while (> level 2)
        (setq level (1- level)
              str (concat str "_")))
      (concat str "_ "))))

(advice-add 'org-clocktable-indent-string :override #'nc--org-clocktable-indent-string)

(setq org-refile-targets (append '((org-default-notes-file :level . 2))
                                 '((nc/org-default-tasks-file :level . 1)
                                   (nc/org-default-projects-file :regexp . "\\(?:\\(?:Note\\|Task\\)s\\)")
                                   (nc/org-default-someday-file :level . 0)
                                   (nil :maxlevel . 3)))) ;; current file

(setq org-blank-before-new-entry nil)

(defun nc--verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'nc--verify-refile-target)

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)

(setq org-refile-allow-creating-parent-nodes 'confirm)

(defun nc--org-subtree-metadata ()
  "Return a list of key aspects of an org-subtree. Includes the
following: header text, body contents, list of tags, region list
of the start and end of the subtree."
  (save-excursion
    ;; Jump to the parent header if not already on a header
    (when (not (org-at-heading-p))
      (org-previous-visible-heading 1))

    (let* ((context (org-element-context))
           (attrs   (cl-second context))
           (props   (org-entry-properties)))

      (list :region     (list (plist-get attrs :begin) (plist-get attrs :end))
            :header     (plist-get attrs :raw-value) ; Use :raw-value because :title returns too more stuff
            :tags       (nc--org-get-subtree-tags props)
            :properties (nc--org-get-subtree-properties attrs)
            :body       (nc--org-get-subtree-content attrs)))))

(defun nc--org-get-subtree-tags (&optional props)
  "Given the properties, PROPS, from a call to
`org-entry-properties', return a list of tags."
  (unless props
     (setq props (org-entry-properties)))
  (let ((tag-label (if nc--org-get-subtree-tags-inherited "ALLTAGS" "TAGS")))
    (-some->> props
         (assoc tag-label)
         cdr
         substring-no-properties
         (s-split ":")
         (--filter (not (cl-equalp "" it))))))

(defvar nc--org-get-subtree-tags-inherited t
  "Returns a subtree's tags, and all tags inherited (from tags
  specified in parents headlines or on the file itself). Defaults
  to true.")

(defun nc--org-get-subtree-properties (attributes)
  "Return a list of tuples of a subtrees properties where the keys are strings."

  (defun symbol-upcase? (sym)
    (let ((case-fold-search nil))
      (string-match-p "^:[A-Z]+$" (symbol-name sym))))

  (defun convert-tuple (tup)
    (let ((key (cl-first tup))
          (val (cl-second tup)))
      (list (substring (symbol-name key) 1) val)))

  (->> attributes
       (-partition 2)                         ; Convert plist to list of tuples
       (--filter (symbol-upcase? (cl-first it))) ; Remove lowercase tuples
       (-map 'convert-tuple)))

(defun nc--org-get-subtree-content (attributes)
  "Return the contents of the current subtree as a string."
  (let ((header-components '(clock diary-sexp drawer headline inlinetask
                             node-property planning property-drawer section)))

      (goto-char (plist-get attributes :contents-begin))

      ;; Walk down past the properties, etc.
      (while
          (let* ((cntx (org-element-context))
                 (elem (cl-first cntx))
                 (props (cl-second cntx)))
            (when (member elem header-components)
              (goto-char (plist-get props :end)))))

      ;; At this point, we are at the beginning of what we consider
      ;; the contents of the subtree, so we can return part of the buffer:
      (buffer-substring-no-properties (point) (org-end-of-subtree))))

(defun nc/org-refile-subtree-to-file (dir)
  "Archive the org-mode subtree and create an entry in the
directory folder specified by DIR. It attempts to move as many of
the subtree's properties and other features to the new file."
  (interactive "DDestination: ")
  (let* ((props      (nc--org-subtree-metadata))
         (head       (plist-get props :header))
         (body       (plist-get props :body))
         (tags       (plist-get props :tags))
         (properties (plist-get props :properties))
         (area       (plist-get props :region))
         (filename   (nc--org-filename-from-title head))
         (filepath   (format "%s/%s.org" dir filename)))
    (apply #'delete-region area)
    (nc/org-create-org-file filepath head body tags properties)))

(defun nc/org-create-org-file (filepath header body tags properties)
  "Create a new Org file by FILEPATH. The contents of the file is
pre-populated with the HEADER, BODY and any associated TAGS."
  (find-file-other-window filepath)
  (nc--org-set-file-property "TITLE" header t)
  (when tags
    (nc--org-set-file-property "FILETAGS" (s-join " " tags)))

  ;; Insert any drawer properties as #+PROPERTY entries:
  (when properties
    (goto-char (point-min))
    (or (re-search-forward "^\s*$" nil t) (point-max))
    (--map (insert (format "#+property: %s %s\n" (cl-first it) (cl-second it))) properties))

  ;; My auto-insert often adds an initial headline for a subtree, and in this
  ;; case, I don't want that... Yeah, this isn't really globally applicable,
  ;; but it shouldn't cause a problem for others.
  (when (re-search-forward "^\\* [0-9]$" nil t)
    (replace-match ""))

  (delete-blank-lines)
  (goto-char (point-max))
  (insert "\n")
  (insert "* " header)
  (insert "\n")
  (insert body))

(defun nc--org-filename-from-title (title)
  "Creates a useful filename based on a header string, TITLE.
For instance, given the string:    What's all this then?
     This function will return:    whats-all-this-then"
  (let* ((no-letters (rx (one-or-more (not alphanumeric))))
         (init-try (->> title
                        downcase
                        (replace-regexp-in-string "'" "")
                        (replace-regexp-in-string no-letters "-"))))
    (string-trim init-try "-+" "-+")))

(defun nc--org-set-file-property (key value &optional spot)
  "Make sure file contains a top-level, file-wide property.
KEY is something like `TITLE' or `FILETAGS'. This function makes
sure that the property contains the contents of VALUE, and if the
file doesn't have the property, it is inserted at either SPOT, or
if nil,the top of the file."
  (save-excursion
    (goto-char (point-min))
    (let ((case-fold-search t))
      (if (re-search-forward (format "^#\\+%s:\s*\\(.*\\)" key) nil t)
          (replace-match value nil nil nil 1)

        (cond
         ;; if SPOT is a number, go to it:
         ((numberp spot) (goto-char spot))
         ;; If SPOT is not given, jump to first blank line:
         ((null spot) (progn (goto-char (point-min))
                             (re-search-forward "^\s*$" nil t)))
         (t (goto-char (point-min))))

        (insert (format "#+%s: %s\n" (upcase key) value))))))


(bind-key "or" 'nc/org-refile-subtree-to-file nc-map)

(defun nc/org-show-next-heading-tidily ()
  "Show next entry, keeping other entries closed."
  (if (save-excursion (end-of-line) (outline-invisible-p))
      (progn (org-show-entry) (show-children))
    (outline-next-heading)
    (unless (and (bolp) (org-on-heading-p))
      (org-up-heading-safe)
      (hide-subtree)
      (error "Boundary reached"))
    (org-overview)
    (org-reveal t)
    (org-show-entry)
    (show-children)))

(defun nc/org-show-previous-heading-tidily ()
  "Show previous entry, keeping other entries closed."
  (let ((pos (point)))
    (outline-previous-heading)
    (unless (and (< (point) pos) (bolp) (org-on-heading-p))
      (goto-char pos)
      (hide-subtree)
      (error "Boundary reached"))
    (org-overview)
    (org-reveal t)
    (org-show-entry)
    (show-children)))

;; Improve speed command behavior
(setq org-use-speed-commands
       (lambda () (and (looking-at org-outline-regexp) (looking-back "^\**"))))

(push '("N" nc/org-show-next-heading-tidily) org-speed-commands)
(push '("P" nc/org-show-previous-heading-tidily) org-speed-commands)
(push '("m" org-mark-subtree) org-speed-commands)


(add-to-list
 'org-speed-commands
 '("!" .
   (progn
     (outline-show-subtree)
     (org-end-of-subtree))))

(defun nc/org-go-speed ()
  "Goes to the beginning of an element's header, so that you can execute speed commands."
  (interactive)
  (when (equal major-mode 'org-mode)
    (if (org-at-heading-p)
        (beginning-of-line)
      (outline-previous-heading))))

(bind-key "C-< C-<" 'nc/org-go-speed org-mode-map)

;; This is needed as of Org 9.2
(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(use-package ob-restclient)

(setq org-plantuml-jar-path
      (expand-file-name "~/opt/lib/plantuml.jar"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (awk .t)
   (python . t)
   (calc . t)
   (js . t)
   (plantuml . t)
   (dot . t)
   (java .t)
   (restclient . t)))

(require 'ob-clojure)

(setq org-src-window-setup 'current-window)

(setq org-confirm-babel-evaluate nil)

(setq org-src-fontify-natively t)

(defun nc--org-time-string-to-seconds (s)
  "Convert a string HH:MM:SS to a number of seconds."
  (cond
   ((and (stringp s)
         (string-match "\\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\)" s))
    (let ((hour (string-to-number (match-string 1 s)))
          (min (string-to-number (match-string 2 s)))
          (sec (string-to-number (match-string 3 s))))
      (+ (* hour 3600) (* min 60) sec)))
   ((and (stringp s)
         (string-match "\\([0-9]+\\):\\([0-9]+\\)" s))
    (let ((min (string-to-number (match-string 1 s)))
          (sec (string-to-number (match-string 2 s))))
      (+ (* min 60) sec)))
   ((stringp s) (string-to-number s))
   (t s)))

(defun nc--org-time-seconds-to-string (secs)
  "Convert a number of seconds to a time string."
  (cond ((>= secs 3600) (format-seconds "%h:%.2m:%.2s" secs))
        ((>= secs 60) (format-seconds "%m:%.2s" secs))
        (t (format-seconds "%s" secs))))

(defmacro nc/with-time (time-output-p &rest exprs)
  "Evaluate an org-table formula, converting all fields that look
like time data to integer seconds.  If TIME-OUTPUT-P then return
the result as a time value."
  (list
   (if time-output-p 'nc--org-time-seconds-to-string 'identity)
   (cons 'progn
         (mapcar
          (lambda (expr)
            `,(cons (car expr)
                    (mapcar
                     (lambda (el)
                       (if (listp el)
                           (list 'with-time nil el)
                         (nc--org-time-string-to-seconds el)))
                     (cdr expr))))
          `,@exprs))))

(defun nc/create-buffer-attachment-directory ()
    "Create assets directory for org mode file"
  (interactive)
  (let ((assets-buffer-dir (file-name-sans-extension (buffer-name) )))
    (f-mkdir "assets" assets-buffer-dir)
    (message "Creation %s folder for current folder" assets-buffer-dir)))

(defun nc/org-syntax-convert-keyword-case-to-lower ()
  "Convert all #+KEYWORDS to #+keywords."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((count 0)
          (case-fold-search nil))
      (while (re-search-forward "^[ \t]*#\\+[A-Z_]+" nil t)
        (unless (s-matches-p "RESULTS" (match-string 0))
          (replace-match (downcase (match-string 0)) t)
          (setq count (1+ count))))
      (message "Replaced %d occurences" count))))

(use-package deft
  :bind
  (("C-c n d" . deft))
  :config
  (setq deft-directory "~/notes"
        deft-recursive t
        deft-extensions '("org")
        deft-default-extension "org"
        deft-text-mode 'org-mode
        deft-org-mode-title-prefix t
        deft-use-filter-string-for-filename t
        deft-auto-save-interval 0
        deft-recursive-ignore-dir-regexp
        (concat "\\(?:"
                "\\."
                "\\|\\.\\."
                "\\\|valtech"
                "\\|journal"
                "\\)$")
        deft-file-naming-rules
        '((noslash . "-")
          (nospace . "-")
          (case-fn . downcase)))

  ;; With Org-roam V2, we need to adapt Deft Title
  ;; Cf https://github.com/jrblevin/deft/issues/75#issuecomment-905031872
  (defun nc/deft-parse-title (file contents)
    "Parse the given FILE and CONTENTS and determine the title.
  If `deft-use-filename-as-title' is nil, the title is taken to
  be the first non-empty line of the FILE.  Else the base name of the FILE is
  used as title."
    (let ((begin (string-match "^#\\+[tT][iI][tT][lL][eE]: .*$" contents)))
      (if begin
          (string-trim (substring contents begin (match-end 0)) "#\\+[tT][iI][tT][lL][eE]: *" "[\n\t ]+")
        (deft-base-filename file))))

  (advice-add 'deft-parse-title :override #'nc/deft-parse-title))

(use-package yankpad    
  :init
  (setq yankpad-file (concat org-directory "/templates/yankpad.org"))
  :config
  ;; If you want to complete snippets using company-mode
  ;; (add-to-list 'company-backends 'company-yankpad)
  ;; If you want to expand snippets with hippie-expand
  (add-to-list 'hippie-expand-try-functions-list #'yankpad-expand)

  :bind
  (:map nc-map ("C-y". yankpad-insert)))

;; (when is-windows  
;;   (add-to-list 'exec-path "C:/ProgramJava/tools/sqlite-tools-win32-x86-3340100"))

(use-package org-roam
  :after org
  :custom
  (org-roam-directory (concat org-directory "/slipbox"))
  :init
  (setq org-roam-v2-ack t)
  :bind
  ("C-c n l" . org-roam-buffer-toggle)
  ("C-c n f" . org-roam-node-find)
  ("C-c n r" . org-roam-node-random)
  (:map org-mode-map
        (("C-c n i" . org-roam-node-insert)))
  :config

  (setq org-roam-capture-templates '(("d" "default" plain "%?"
                                      :if-new
                                      (file+head "%<%Y-%m-%d--%H-%M>--${slug}.org"
                                                 "#+title: ${title}\n#+date: %u\n\n")
                                      :unnarrowed t
                                      :immediate-finish t))
        )
  ;; this sets up various file handling hooks so your DB remains up to date
  (org-roam-setup))

;; Orgnaize org roam notes
;; Adapted from https://jethrokuan.github.io/org-roam-guide/

(cl-defmethod org-roam-node-type ((node org-roam-node))
  "Return the TYPE of NODE."
  (condition-case nil
      (file-name-nondirectory
       (directory-file-name
        (file-name-directory
         (file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "main")))

(setq org-roam-node-display-template
      (concat "${type:15} ${title:*} " (propertize "${tags:15}" 'face 'org-tag)))

(provide 'setup-org)
;;; setup-org.el ends here
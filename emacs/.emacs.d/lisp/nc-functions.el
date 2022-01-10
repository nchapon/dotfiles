(defun nc/goto-emacs-config ()
    "Edit Readme.org"
    (interactive)
    (find-file "~/.emacs.d/Readme.org"))

(defun nc/goto-my-credentials ()
    "Goto my credentials"
    (interactive)
    ;; before disable super-save-mode
    ;;(super-save-stop)
    (find-file (concat nc/org-default-personal-dir "/password.gpg")))

(bind-key "gp" 'nc/goto-my-credentials nc-map)

(defun nc--random-alnum ()
  (let* ((alnum "abcdef0123456789")
         (i (% (abs (random)) (length alnum))))
    (substring alnum i (1+ i))))

(defun nc/uuid ()
  "Generate a pseudo UUID"
  (interactive)
  (dotimes (i 32) (insert (nc--random-alnum))))

(bind-key "iu" 'nc/uuid nc-map)

(defun nc--random-char ()
    (let* ((alnum "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-/%+*?&#[]()={}_<>!$,;:^µ0123456789")
           (i (% (abs (random)) (length alnum))))
      (substring alnum i (1+ i))))


(defun nc/generate-password ()
    "Generates a strong password"
    (interactive)
    (dotimes (i 12) (insert (nc--random-char))))

(bind-key "ip" 'nc/generate-password nc-map)

(defvar current-hour-format "%H:00")

(defun nc/insert-time-slot ()
  "Insert Time Slot"
  (interactive)
  (let ((begin (format-time-string current-hour-format (current-time)))
        (end (format-time-string current-hour-format (time-add (current-time) (seconds-to-time 3600)))))
    (insert (concat begin "-" end))))

(bind-key "it" 'nc/insert-time-slot nc-map)

(defun nc/insert-datestamp()
  "Insert the current date in yyyy-mm-dd format."
  (interactive "*")
  (if (eq major-mode 'org-mode)
      (progn
        (org-insert-time-stamp nil nil nil)
        (insert " "))
      (insert (format-time-string "%Y-%m-%d" (current-time)))))

(bind-key "id" 'nc/insert-datestamp nc-map)

(defun nc/insert-datestamp-inactive()
  "Insert the current date in yyyy-mm-dd format."
  (interactive "*")
  (if (eq major-mode 'org-mode)
      (progn
    (org-insert-time-stamp nil nil t)
    (insert " "))
    (insert (format-time-string "%Y-%m-%d" (current-time)))))

(bind-key "iD" 'nc/insert-datestamp-inactive nc-map)

(defun nc/search-notes ()
  "Search in all my org notes"
  (interactive)
  (consult-ripgrep org-directory ""))

(bind-key "sn" 'nc/search-notes nc-map)

(defun nc/sudo-find-file (file)
  "Open FILE as root."
  (interactive "FOpen file as root: ")
  (when (file-writable-p file)
    (user-error "File is user writeable, aborting sudo"))
  (find-file (if (file-remote-p file)
                 (concat "/" (file-remote-p file 'method) ":"
                         (file-remote-p file 'user) "@" (file-remote-p file 'host)
                         "|sudo:root@"
                         (file-remote-p file 'host) ":" (file-remote-p file 'localname))
               (concat "/sudo:root@localhost:" file))))

(provide 'nc-functions)
;;; nc-functions.el ends here

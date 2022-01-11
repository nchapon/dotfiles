(use-package ace-window
  :bind (([remap other-window] . ace-window))
  :config
  (setq aw-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l))
  ;; increase size face
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 3.0))))))

(use-package golden-ratio
  :diminish t
  :init
  (golden-ratio-mode 1)
  :config
  (setq golden-ratio-extra-commands
        (append golden-ratio-extra-commands
                '(ace-window))))

(defun nc/toggle-split-window-horizontally ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(bind-key "wh" 'nc/toggle-split-window-horizontally nc-map)

(defun nc--split-window-right-and-move-there-dammit ()
  (split-window-right)
  (windmove-right))

(defun nc/toggle-split-window-vertically ()
  (interactive)
  (if (> (count-windows) 1)
      (delete-other-windows)
    (nc--split-window-right-and-move-there-dammit)))

(bind-key "wv" 'nc/toggle-split-window-vertically nc-map)
(bind-key "C-w" 'nc/toggle-split-window-vertically nc-map)

(provide 'setup-windows)
;;; setup-windows.el ends here

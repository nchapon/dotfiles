;;; early-init.el --- Early initialization -*- lexical-binding: t; buffer-read-only: t; no-byte-compile: t -*-

;; Author: Nicolas CHAPON
;; Keywords: Emacs configuration
;; Homepage:

;;; Commentary:
;; Emacs config file.
;; This file was automatically generated by `org-babel-tangle'.
;; Do not change this file.  Main config is located in Readme.org at `user-emacs-directory'

;;; Code:

(defvar nc--gc-cons-threshold gc-cons-threshold)
(defvar nc--gc-cons-percentage gc-cons-percentage)
(defvar nc--file-name-handler-alist file-name-handler-alist)

(setq-default gc-cons-threshold 402653184
              gc-cons-percentage 0.6
              file-name-handler-alist nil)

(defun nc/restore-defaults-after-init ()
  "Restore default values after initialization."
  (setq-default gc-cons-threshold nc--gc-cons-threshold
                gc-cons-percentage nc--gc-cons-percentage
                file-name-handler-alist nc--file-name-handler-alist))

(add-hook 'after-init-hook #'nc/restore-defaults-after-init)

(setq read-process-output-max (* 1024 1024 4) ; 4mb
      inhibit-compacting-font-caches t
      message-log-max 16384)

(defvar straight-process-buffer)
(setq-default straight-process-buffer " *straight-process*")

(defvar straight-build-dir)
(setq straight-build-dir (format "build-%s" emacs-version))

(defvar bootstrap-version)
(let ((bootstrap-file
   (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
  (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
    (url-retrieve-synchronously
     "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
     'silent 'inhibit-cookies)
  (goto-char (point-max))
  (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-enable-at-startup nil)

(setq load-prefer-newer noninteractive)

(provide 'early-init)
;;; early-init.el ends here

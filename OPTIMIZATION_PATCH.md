# Emacs Configuration Optimization Patch

This patch addresses deprecated settings, performance issues, and redundancies in the Emacs configuration.

## Changes Overview

### 1. Fix Garbage Collection Restoration (HIGH PRIORITY)
**File**: `emacs/.emacs.d/Readme.org`
**Section**: Early Init - Garbage Collection and Performance
**Lines**: 58-62

**Problem**: `gc-cons-threshold` is not properly restored after init, only `file-name-handler-alist` is restored.

**Current**:
```elisp
(defun nc/restore-defaults-after-init ()
  "Restore default values after initialization."
  (setq-default file-name-handler-alist nc--file-name-handler-alist))
```

**Fixed**:
```elisp
(defun nc/restore-defaults-after-init ()
  "Restore default values after initialization."
  (setq-default gc-cons-threshold nc--gc-cons-threshold
                gc-cons-percentage nc--gc-cons-percentage
                file-name-handler-alist nc--file-name-handler-alist))
```

---

### 2. Remove Duplicate `transient` Declaration (HIGH PRIORITY)
**File**: `emacs/.emacs.d/Readme.org`
**Section**: Key Bindings - Transient Menus
**Lines**: 886-889

**Problem**: `use-package transient` is declared twice (lines 887-888 and 893-894).

**Current**:
```elisp
** Transient Menus

Be sure transient is loaded.

#+begin_src emacs-lisp
(use-package transient
    :commands (transient-define-prefix))
#+end_src

*** File Menu
#+begin_src emacs-lisp
(use-package transient
    :commands (transient-define-prefix))
;; Stolen from Doom
```

**Fixed**: Remove the duplicate (lines 893-894) and keep only one declaration.

---

### 3. Fix `with-eval-after-load` Syntax (HIGH PRIORITY)
**File**: `emacs/.emacs.d/Readme.org`
**Section**: UI - Theme
**Lines**: 567-568

**Problem**: Using string `'org-mode` instead of symbol `'org` in `with-eval-after-load`.

**Current**:
```elisp
;; Corrects (and improves) org-mode's native fontification.
(with-eval-after-load 'org-mode
    (doom-themes-org-config))
```

**Fixed**:
```elisp
;; Corrects (and improves) org-mode's native fontification.
(with-eval-after-load 'org
    (doom-themes-org-config))
```

---

### 4. Remove Deprecated `transient-mark-mode` (MEDIUM PRIORITY)
**File**: `emacs/.emacs.d/Readme.org`
**Section**: Global Preferences - Better Defaults
**Lines**: 258

**Problem**: `transient-mark-mode` is enabled by default since Emacs 24.4.

**Current**:
```elisp
(use-package emacs
  :straight nil
  :custom
  (initial-major-mode 'lisp-interaction-mode)
  (redisplay-dont-pause t)
  (column-number-mode t)
  (echo-keystrokes 0.02)
  (fill-column 80)
  (transient-mark-mode t)  ; <-- REMOVE THIS LINE
  (shift-select-mode nil)
  ...
```

**Fixed**: Delete line containing `(transient-mark-mode t)`.

---

### 5. Remove Duplicate Font Setup (MEDIUM PRIORITY)
**File**: `emacs/.emacs.d/Readme.org`
**Section**: UI - Emojify
**Lines**: 600-602

**Problem**: Font setup is duplicated; already configured in emojify `:config` block.

**Current**:
```elisp
** Emojify

ℹ️ All-The-Icons and Noto Emoji should be installed

#+begin_src emacs-lisp
(setf use-default-font-for-symbols nil)
(set-fontset-font t 'unicode "Noto Emoji" nil 'append)

(use-package emojify
    :hook (after-init . global-emojify-mode)
    :config

    (set-fontset-font "fontset-default" 'symbol "Noto Color Emoji" nil 'append)
    ...
```

**Fixed**: Remove lines 601-602 (before `use-package emojify`):
```elisp
** Emojify

ℹ️ All-The-Icons and Noto Emoji should be installed

#+begin_src emacs-lisp
(use-package emojify
    :hook (after-init . global-emojify-mode)
    :config

    (set-fontset-font "fontset-default" 'symbol "Noto Color Emoji" nil 'append)
    ...
```

---

### 6. Consolidate UTF-8 Configuration (MEDIUM PRIORITY)
**File**: `emacs/.emacs.d/Readme.org`
**Section**: Global Preferences - UTF-8 Encoding
**Lines**: 349-362

**Problem**: Excessive UTF-8 configuration; most settings are redundant.

**Current**:
```elisp
** UTF-8 Encoding

 Set all coding systems to utf-8
 #+begin_src emacs-lisp
 (prefer-coding-system 'utf-8-unix)
 (set-clipboard-coding-system 'utf-8-unix)
 (set-default-coding-systems 'utf-8-unix)
 (set-keyboard-coding-system 'utf-8-unix)
 (set-language-environment 'utf-8)
 (set-selection-coding-system 'utf-8-unix)
 (set-terminal-coding-system 'utf-8-unix)
 (setq locale-coding-system 'utf-8-unix)
 (setq coding-system-for-write 'utf-8-unix)
 (setq default-buffer-file-coding-system 'utf-8-unix)
 (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
 (setq file-name-coding-system  'utf-8)
 (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
 #+end_src
```

**Fixed** (simplified):
```elisp
** UTF-8 Encoding

 Set all coding systems to utf-8
 #+begin_src emacs-lisp
 (prefer-coding-system 'utf-8-unix)
 (setq locale-coding-system 'utf-8-unix)
 #+end_src
```

---

### 7. Remove `:ensure t` from `general` package (MEDIUM PRIORITY)
**File**: `emacs/.emacs.d/Readme.org`
**Section**: Key Bindings - Setup & Leader Definitions
**Lines**: 740-741

**Problem**: Using `straight.el` but also specifying `:ensure t` (which is for `package.el`).

**Current**:
```elisp
#+begin_src emacs-lisp
(use-package general
  :ensure t
  :config
```

**Fixed**:
```elisp
#+begin_src emacs-lisp
(use-package general
  :config
```

---

### 8. Resolve TODO Marker (LOW PRIORITY)
**File**: `emacs/.emacs.d/Readme.org`
**Section**: Global Preferences - Indentation & Tabs
**Lines**: 290-293

**Problem**: TODO marker indicates incomplete feature.

**Current**:
```elisp
*** TODO Indent new line if necessary
Remove to bindings
#+begin_src emacs-lisp
 (define-key global-map (kbd "RET") 'newline-and-indent)
 #+end_src
```

**Option A** - Keep feature (rename section):
```elisp
*** Indent new line automatically
#+begin_src emacs-lisp
 (define-key global-map (kbd "RET") 'newline-and-indent)
 #+end_src
```

**Option B** - Move to use-package (recommended):
```elisp
*** Indent new line automatically
#+begin_src emacs-lisp
(use-package emacs
  :straight nil
  :bind ("<return>" . newline-and-indent))
 #+end_src
```

---

### 9. Improve GC Statistics Performance (OPTIONAL)
**File**: `emacs/.emacs.d/Readme.org`
**Section**: Early Init - Straight
**Lines**: 80-81

**Problem**: Computing statistics on every package can slow down init.

**Current**:
```elisp
;; Compute use pacakge stats
(setq use-package-compute-statistics t)
```

**Recommended**:
```elisp
;; Compute use-package stats (disable for faster startup)
;; (setq use-package-compute-statistics t)

;; To profile startup: (setq use-package-compute-statistics t)
;; Then run: M-x use-package-report
```

---

## Summary

| Priority | Item | Impact |
|----------|------|--------|
| 🔴 HIGH | GC restoration | Prevents excessive memory usage post-init |
| 🔴 HIGH | Duplicate transient | Prevents loading package twice |
| 🔴 HIGH | org-mode hook fix | Ensures doom-themes applies to org correctly |
| 🟡 MEDIUM | Remove transient-mark-mode | Cleaner config (already default) |
| 🟡 MEDIUM | Duplicate fonts | Removes redundant code |
| 🟡 MEDIUM | Consolidate UTF-8 | Improves readability, same effect |
| 🟡 MEDIUM | Remove :ensure t | Consistency with straight.el |
| 🟢 LOW | TODO marker | Completes incomplete work |
| 🟢 OPTIONAL | GC statistics | Optional performance tweak |

## Testing After Patch

After applying these changes, verify:

1. **GC**: Monitor memory usage during and after startup
2. **Keybindings**: Test `C-q` leader bindings work
3. **Theme**: Verify org-mode syntax highlighting is correct
4. **Startup**: Check startup time (should be same or faster)

Run this to profile:
```elisp
;; In early-init.el temporarily:
(defvar my/init-start-time (current-time))
;; In init.el at end:
(message "Init took %.2f seconds" 
         (float-time (time-since my/init-start-time)))
```

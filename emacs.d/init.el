(require 'cl) ; for powerline

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
;(add-to-list 'package-archives
;             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit
                      starter-kit-bindings
                      starter-kit-lisp
                      starter-kit-ruby
                      color-theme-solarized
                      clojure-mode
                      clojure-test-mode
                      clojurescript-mode)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; packages from git

(add-to-list 'load-path "~/.emacs.d/my-pkgs/evil")
(require 'evil)
(evil-mode 1)

(setq linum-format "%4d ")

;; appearance
(load-theme 'solarized-dark t)

(defun terminal-init-rxvt-unicode ()
  "Terminal initialization function for rxvt-unicode."
  ;; Use the xterm color initialization code.
  (load "term/xterm")
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(esk-paren-face ((t (:foreground "color-238")))))

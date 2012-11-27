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
(defvar my-packages '(color-theme-solarized
                      clojure-mode
                      clojure-test-mode
                      clojurescript-mode
                      slime-ritz
                      slime-repl
                      nrepl-ritz
                      ac-nrepl
                      ack-and-a-half
                      multi-term
                      tidy
                      yasnippet
                      yas-jit
                      starter-kit
                      starter-kit-bindings
                      starter-kit-lisp
                      starter-kit-ruby)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

; my own config that is loaded AFTER packages are loaded
; if I use the esk hooks then it ends up loading things before
; all packages are loaded
(setq my-config-dir (concat user-emacs-directory "my-config"))
(when (file-exists-p my-config-dir)
        (mapc 'load (directory-files my-config-dir t "^[^#].*el$")))

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
 '(esk-paren-face ((t (:foreground "color-239"))))
 '(whitespace-trailing ((t (:background "cyan" :foreground "#cd0000" :inverse-video nil :underline nil :slant normal :weight bold)))))

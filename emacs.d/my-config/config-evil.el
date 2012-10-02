;; Config for EVIL
(add-to-list 'load-path "~/.emacs.d/my-pkgs/evil")
(add-to-list 'load-path "~/.emacs.d/my-pkgs/evil-leader")

; make sure we have our C-w window navigation bindings available all times
(setq evil-want-C-w-in-emacs-state t)

(require 'evil)
(evil-mode 1)

(require 'evil-leader)

;easy switching between files and buffers using ffip and ido
(let ((maps (list evil-normal-state-map evil-insert-state-map evil-visual-state-map)))
 (dolist (map maps)
   (define-key map "\C-p" 'find-file-in-project)
   (define-key map "\C-b" 'ido-switch-buffer)))

;paredit barfage and slurpage
(evil-leader/set-key ")" 'paredit-forward-slurp-sexp)
(evil-leader/set-key "}" 'paredit-forward-barf-sexp)
(evil-leader/set-key "(" 'paredit-backward-slurp-sexp)
(evil-leader/set-key "{" 'paredit-backward-barf-sexp)

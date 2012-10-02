;; Config for EVIL

(add-to-list 'load-path "~/.emacs.d/my-pkgs/evil")
(require 'evil)
(evil-mode 1)

(add-to-list 'load-path "~/.emacs.d/my-pkgs/evil-leader")
(require 'evil-leader)

;ffip binding
(let ((maps (list evil-normal-state-map evil-insert-state-map evil-visual-state-map)))
 (dolist (map maps)
   (define-key map "\C-p" 'find-file-in-project)
   (define-key map "\C-b" 'ido-switch-buffer)))

;; Config for EVIL
(add-to-list 'load-path "~/.emacs.d/my-pkgs/evil")
(add-to-list 'load-path "~/.emacs.d/my-pkgs/evil-leader")

;; make sure we have our C-w window navigation bindings available all times
(setq evil-want-C-w-in-emacs-state t)

(require 'evil)
(evil-mode 1)

(require 'evil-leader)
(setq evil-leader/in-all-states t)

;; easy switching between files and buffers using ffip and ido
(let ((maps (list evil-normal-state-map evil-insert-state-map evil-visual-state-map)))
 (dolist (map maps)
   (define-key map (kbd "C-p") 'find-file-in-project)
   (define-key map (kbd "C-b") 'ido-switch-buffer)))

;; TAB insert mode
(defun after-whitespace-p ()
  (string-match "[ \t\n]" (string (char-before))))

(defun my-super-tab ()
  (interactive)
   (if (after-whitespace-p)
      (indent-for-tab-command)
     (cond ((and (boundp 'slime-mode) slime-mode) (slime-complete-symbol))
           (t (completion-at-point)))))

(define-key evil-insert-state-map (kbd "TAB") 'my-super-tab)

;; paredit barfage and slurpage
(evil-leader/set-key ")" 'paredit-forward-slurp-sexp)
(evil-leader/set-key "}" 'paredit-forward-barf-sexp)
(evil-leader/set-key "(" 'paredit-backward-slurp-sexp)
(evil-leader/set-key "{" 'paredit-backward-barf-sexp)

;; comment/uncomment
(evil-leader/set-key "/" 'comment-or-uncomment-region)

(evil-leader/set-key "f" 'ack)
(evil-leader/set-key "F" 'ack-same)

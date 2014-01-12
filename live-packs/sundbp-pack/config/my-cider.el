(require 'cider)
(require 'cider-repl)
(require 'nrepl-client)

(custom-set-variables '(cider-repl-use-pretty-printing t)
                      '(cider-repl-history-file "~/.cider-history"))

(require 'cider-inspect)
(define-key cider-mode-map (kbd "C-c C-i") 'cider-inspect)

(defun cider-reset ()
  (interactive)
  (cider-load-file (concat (nrepl-project-directory-for (nrepl-current-dir)) "dev/user.clj"))
  (switch-to-buffer-other-window (cider-current-repl-buffer))
  (goto-char (point-max))
  (insert "(user/reset)")
  (cider-repl-return)
  (message "Started system refresh via tools.namespace."))

(global-set-key (kbd "C-c M-k") 'cider-reset)

(dolist (mode '(cider-repl-mode))
  (add-to-list 'ac-modes mode))

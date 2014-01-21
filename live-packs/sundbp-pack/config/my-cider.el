(require 'cider)
(require 'cider-repl)
(require 'nrepl-client)
(require 'cider-macroexpansion)

(custom-set-variables '(cider-repl-use-pretty-printing t)
                      '(cider-repl-history-file "~/.cider-history"))

(require 'cider-inspect)
(define-key cider-mode-map (kbd "C-c C-i") 'cider-inspect)

(defun sundbp-cider-reset ()
  (interactive)
  (let ((user-file (concat (nrepl-project-directory-for (nrepl-current-dir)) "dev/user.clj")))
    (cider-switch-to-relevant-repl-buffer '())
    (cider-load-file user-file)
    (goto-char (point-max))
    (insert "(user/recompile)")
    (cider-repl-return)
    (message "Started session refresh via tools.namespace.")))

(dolist (mode '(cider-repl-mode))
  (add-to-list 'ac-modes mode))

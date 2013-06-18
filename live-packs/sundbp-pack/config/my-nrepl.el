(require 'nrepl)

(custom-set-variables '(nrepl-use-pretty-printing t)
                      '(nrepl-history-file "~/.nrepl-history"))

(require 'nrepl-inspect)
(define-key nrepl-mode-map (kbd "C-c C-i") 'nrepl-inspect)

(defun nrepl-reset ()
  (interactive)
  (set-buffer "*nrepl*")
  (goto-char (point-max))
  (insert "(user/reset)")
  (nrepl-return)
  (message "Started system refresh via tools.namespace."))

(global-set-key (kbd "C-c M-k") 'nrepl-reset)

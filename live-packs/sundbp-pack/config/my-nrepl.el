(custom-set-variables '(nrepl-use-pretty-printing t)
                      '(nrepl-history-file "~/.nrepl-history"))

(require 'nrepl-inspect)
(define-key nrepl-mode-map (kbd "C-c C-i") 'nrepl-inspect)

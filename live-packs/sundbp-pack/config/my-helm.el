(require 'helm)
(require 'helm-nrepl)

;; help for navigating clojure
(defun helm-clojure-headlines ()
  "Display headlines for the current Clojure file."
  (interactive)
  (helm :sources '(((name . "Clojure Headlines")
                    (volatile)
                    (headline "^[;(]")))))

;; ffip
(global-unset-key "\C-p")
(global-set-key (kbd "C-p") 'find-file-in-project)

;; buffer search
(global-unset-key "\C-b")
(global-set-key (kbd "C-b") 'ido-switch-buffer)

;; make sure that Ctrl+up|down|left|right works in terminal
(define-key input-decode-map "\eOa" [(control up)])
(define-key input-decode-map "\e[1;5A" [(control up)])
(define-key input-decode-map "\eOb" [(control down)])
(define-key input-decode-map "\e[1;5B" [(control down)])
(define-key input-decode-map "\eOd" [(control left)])
(define-key input-decode-map "\e[1;5D" [(control left)])
(define-key input-decode-map "\eOc" [(control right)])
(define-key input-decode-map "\e[1;5C" [(control right)])

;; My key bindings

;; make sure that Ctrl+up|down|left|right works in terminal
(define-key input-decode-map "\eOa" [(control up)])
(define-key input-decode-map "\e[1;5A" [(control up)])
(define-key input-decode-map "\eOb" [(control down)])
(define-key input-decode-map "\e[1;5B" [(control down)])
(define-key input-decode-map "\eOd" [(control left)])
(define-key input-decode-map "\e[1;5D" [(control left)])
(define-key input-decode-map "\eOc" [(control right)])
(define-key input-decode-map "\e[1;5C" [(control right)])
;; alt-pgup/pgdown
(define-key input-decode-map "\e[5;5~" [(meta prior)])
(define-key input-decode-map "\e[5;6~" [(meta next)])
(define-key input-decode-map "\e[5;3~" [(meta prior)])
(define-key input-decode-map "\e[6;3~" [(meta next)])

;; ffip
(global-set-key  (kbd "C-x p") 'find-file-in-project)

;; window movements
(global-set-key  (kbd "C-x <up>") 'windmove-up)
(global-set-key  (kbd "C-x <down>") 'windmove-down)
(global-set-key  (kbd "C-x <left>") 'windmove-left)
(global-set-key  (kbd "C-x <right>") 'windmove-right)

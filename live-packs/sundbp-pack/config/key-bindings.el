;; My key bindings

;; C-up|down|left|right in terminal
(define-key input-decode-map "\eOa" [(control up)])
(define-key input-decode-map "\e[1;5A" [(control up)])
(define-key input-decode-map "\eOb" [(control down)])
(define-key input-decode-map "\e[1;5B" [(control down)])
(define-key input-decode-map "\eOd" [(control left)])
(define-key input-decode-map "\e[1;5D" [(control left)])
(define-key input-decode-map "\eOc" [(control right)])
(define-key input-decode-map "\e[1;5C" [(control right)])

;; M-up|down|left|right in terminal
(define-key input-decode-map "\e[1;3A" [(meta up)])
(define-key input-decode-map "\e[1;3B" [(meta down)])
(define-key input-decode-map "\e[1;3D" [(meta left)])
(define-key input-decode-map "\e[1;3C" [(meta right)])

;; C-M-up|down|left|right in terminal
(define-key input-decode-map "\e[1;7A" [(control meta up)])
(define-key input-decode-map "\e[1;7B" [(control meta down)])
(define-key input-decode-map "\e[1;7D" [(control meta left)])
(define-key input-decode-map "\e[1;7C" [(control meta right)])

;; M-pgup/pgdown in terminal
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

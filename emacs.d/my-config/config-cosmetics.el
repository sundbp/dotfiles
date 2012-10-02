;; Setup my preferred theme - Solarized

(load-theme 'solarized-dark t)

(defun terminal-init-rxvt-unicode ()
  "Terminal initialization function for rxvt-unicode."
  ;; Use the xterm color initialization code.
  (load "term/xterm")
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))

; format of line numbers
(setq linum-format "%4d ")
; show line numbers
(global-linum-mode t)

;; display only tails of long lines, tabs and trailing whitespaces
(setq whitespace-line-column 120
      whitespace-style '(face trailing tabs lines-tail empty))

;; highlight ending whitespace
(global-whitespace-mode t)

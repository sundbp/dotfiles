;; setting related to visual appearance

;; use solarized
(color-theme-solarized-dark)

;; stuff copied from customize system
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(esk-paren-face ((t (:foreground "color-239"))))
 '(whitespace-trailing ((t (:background "cyan" :foreground "#cd0000" :inverse-video nil :underline nil :slant normal :weight bold)))))

;; Make sure we get the right terminal colors in rxvt
(defun terminal-init-rxvt-unicode ()
  "Terminal initialization function for rxvt-unicode."
  ;; Use the xterm color initialization code.
  (load "term/xterm")
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))

;; format of line numbers
;;(setq linum-format "%4d ")
;;(global-linum-mode t)

;; display only tails of long lines, tabs and trailing whitespaces
(setq whitespace-line-column 120
      whitespace-style '(face trailing tabs lines-tail empty))

;; highlight ending whitespace
(global-whitespace-mode t)

;; ediff
(setq ediff-split-window-function 'split-window-horizontally)

;; full screen magit-status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))
(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))
(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

;; stop blinking the cursor
(blink-cursor-end)


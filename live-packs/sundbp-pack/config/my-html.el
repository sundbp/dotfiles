;;(eval-after-load "sgml-mode"
;;  '(progn
;;     (require 'tagedit)
;;     (tagedit-add-paredit-like-keybindings)
;;     ;;(tagedit-add-experimental-features)
;;     (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))
;;     (define-key html-mode-map (kbd "s-k") 'tagedit-kill-attribute)
;;     (define-key html-mode-map (kbd "s-<return>") 'tagedit-toggle-multiline-tag)))

;; after deleting a tag, indent properly
;;(defadvice sgml-delete-tag (after reindent activate)
;;  (indent-region (point-min) (point-max)))

;;(require 'emmet-mode)
;;(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
;;(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

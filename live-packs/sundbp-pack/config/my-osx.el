(when (eq system-type 'darwin)
  ;; mac keys
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super)

  ;; font style and size for osx cocoa
  (remove-if (lambda (x)
               (eq 'font (car x)))
             default-frame-alist)
  (cond
   ((and (window-system) (eq system-type 'darwin))
    (add-to-list 'default-frame-alist '(font . "Monaco 14")))))

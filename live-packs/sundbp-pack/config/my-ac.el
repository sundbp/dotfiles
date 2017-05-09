;;(setq ac-disable-faces nil)

(global-auto-complete-mode nil)
(setq ac-modes '())

;; autocomplete everything with company-mode!
(add-hook 'after-init-hook 'global-company-mode)

(setq company-dabbrev-code-everywhere nil)
(setq company-dabbrev-code-other-buffers t)

(setq company-idle-delay 0.5)
(setq company-tooltip-limit 10)
(setq company-minimum-prefix-length 2)
(setq company-tooltip-flip-when-above t)

(require 'company-quickhelp)
(company-quickhelp-mode 1)

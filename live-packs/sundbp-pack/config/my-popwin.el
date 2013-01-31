;; patch magit diff window to not be too tall for mbp in tmux
(setq popwin:special-display-config
      (mapcar '(lambda (x)
                 (if (string= (car x) "*magit-diff*")
                     '("*magit-diff*" :noselect t :height 30 :width 80)
                   x))
              popwin:special-display-config))

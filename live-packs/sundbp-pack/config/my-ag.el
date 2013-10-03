(require 'ag)
;; Create shorter aliases
(defalias 'agp 'ag-project)
(defalias 'agpp 'ag-project-at-point)
(defalias 'agrp 'ag-regexp-project)
(defalias 'agrpp 'ag-regexp-project-at-point)
(setq ag-highlight-search t)
(setq ag-arguments (list "--smart-case" "--nogroup" "--column" "--skip-vcs-ignores" "--ignore generated/*" "--"))

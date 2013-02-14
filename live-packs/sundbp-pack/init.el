;; sundbp pack init file

;; first make sure the marmelade packages we rely on are installed
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; The marmelade packages I use:
(defvar my-marmelade-packages '(color-theme-solarized
                                slamhound)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-marmelade-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; then load my config files
(live-load-config-file "cosmetics.el")
(live-load-config-file "key-bindings.el")
(live-load-config-file "ffip.el")
(live-load-config-file "ag.el")
(live-load-config-file "my-popwin.el")

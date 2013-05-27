;; sundbp pack init file

;; first make sure the marmelade packages we rely on are installed
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; The marmelade packages I use:
(defvar my-marmelade-packages '(slamhound
                                expectations-mode)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-marmelade-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; no zoning!
(setq live-disable-zone t)

;; then load my config files
(live-load-config-file "cosmetics.el")
(live-load-config-file "key-bindings.el")
(live-load-config-file "ffip.el")
(live-load-config-file "ag.el")
(live-load-config-file "my-popwin.el")
;;(live-load-config-file "my-git-gutter-fringe.el")
(live-load-config-file "my-osx.el")
(live-load-config-file "my-ansi-term.el")
(live-load-config-file "my-nrepl.el")
(live-load-config-file "my-clojure.el")

;; try to load non-git versioned pw file
(load "pw" t)

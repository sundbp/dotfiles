;; sundbp pack init file

;; first make sure the marmelade packages we rely on are installed
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;(package-refresh-contents)

;; The marmelade packages I use:
;;(defvar my-marmelade-packages '(slamhound
;;                                company
;;                                company-quickhelp
;;                                ;;expectations-mode
;;                                coffee-mode
;;                                tagedit
;;                                helm
;;                                helm-ag)
;;  "A list of packages to ensure are installed at launch.")

;;(dolist (p my-marmelade-packages)
;;  (when (not (package-installed-p p))
;;    (package-install p)))

;; no zoning!
(setq live-disable-zone t)

;; then load my config files
(live-load-config-file "cosmetics.el")
(live-load-config-file "key-bindings.el")
(live-load-config-file "my-ffip.el")
(live-load-config-file "my-ag.el")
(live-load-config-file "my-popwin.el")
;;(live-load-config-file "my-git-gutter-fringe.el")
(live-load-config-file "my-osx.el")
(live-load-config-file "my-ansi-term.el")
(live-load-config-file "my-cider.el")
(live-load-config-file "my-clojure.el")
(live-load-config-file "my-html.el")
;;(live-load-config-file "my-edit-server.el")
(live-load-config-file "my-ac.el")

;; try to load non-git versioned pw file
(load "refheap" t)
(load "pw" t)

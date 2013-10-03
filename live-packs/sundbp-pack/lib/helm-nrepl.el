;;; helm-nrepl.el --- Utilities for Clojure programming using helm and nrepl.el

;; Copyright (C) 2012 Ozan Sener <ozan@ozansener.com>

;; Author: Ozan Sener <ozan@ozansener.com>
;; URL: https://github.com/osener/helm-nrepl
;; Keywords: languages, clojure, nrepl, helm
;; Version: 0.1
;; Package-Requires: ((nrepl "0.1") (helm "20120823"))

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'nrepl)
(require 'helm-elisp)

(defun helm-nrepl-arglist (symbol)
  "Return argument list for the given SYMBOL, if available."
  (let ((form (format "(try (:arglists (meta (resolve (read-string \"%s\"))))
                         (catch Throwable t nil))"
                       symbol))
        (namespace (with-helm-current-buffer (nrepl-current-ns))))
    (plist-get (nrepl-send-string-sync form namespace) :value)))

(defun helm-nrepl-brief-documentation (symbol)
  "Return documentation for the given SYMBOL, if available."
  (let* ((form (format "(try (:doc (meta (resolve (read-string \"%s\"))))
                         (catch Throwable t nil))" symbol))
         (namespace (with-helm-current-buffer (nrepl-current-ns)))
         (symbol-doc
          (car (read-from-string
                (plist-get (nrepl-send-string-sync form namespace)
                           :value)))))
    (if symbol-doc
        (replace-regexp-in-string "\\(\n\\|  \\)" "" symbol-doc)
      "Not documented")))

(defun helm-nrepl-show-documentation (candidate)
  "Helm persistent action for viewing symbol documentation."
  (let ((cursor-in-echo-area t)
        mode-line-in-non-selected-windows)
    (helm-c-show-info-in-mode-line
     (propertize
      (helm-nrepl-brief-documentation candidate)
      'face 'helm-lisp-completion-info))))

(defun helm-nrepl-open-documentation (candidate)
  "Display documentation for the given symbol in another window."
  (with-helm-current-buffer (nrepl-doc-handler candidate)))

(defvar longest-symbol 0)

(defun helm-nrepl-candidates (pattern)
  "Return all possible candidates in current namespace for the given PATTERN."
  (let* ((form (format "(complete.core/completions \"%s\")" pattern))
         (namespace (with-helm-current-buffer (nrepl-current-ns)))
         (candidates (car (read-from-string
                           (plist-get
                            (nrepl-send-string-sync
                             form
                             namespace)
                            :value)))))
    (setq longest-symbol (apply 'max (cons 0 (mapcar 'length candidates))))
    candidates))


(defun helm-nrepl-append-signature (candidates source)
  "Append function signature to each item in CANDIDATES."
  (mapcar (lambda (symbol)
            (let ((spaces (make-string (- longest-symbol (length symbol) -1) ? ))
                  (args (helm-nrepl-arglist symbol)))
              (cons (concat symbol spaces args) symbol)))
          candidates))

(defvar helm-source-nrepl
  '((name . "Nrepl completion")
    (candidates . (lambda ()
                    (helm-nrepl-candidates helm-pattern)))
    (action . (("Insert symbol" . (lambda (symbol)
                                    (delete-region beg end)
                                    (insert symbol)))
               ("Show documentation" . helm-nrepl-open-documentation)
               ("Jump to definition" . (lambda (symbol)
                                         (with-helm-current-buffer
                                           (nrepl-jump-to-def symbol))))))
    (persistent-action . helm-nrepl-show-documentation)
    (persistent-help . "Show brief documentation in mode-line")
    (filtered-candidate-transformer . helm-nrepl-append-signature)
    (volatile)
    (requires-pattern . 2)))

;;;###autoload
(defun helm-nrepl-complete ()
  "Preconfigured helm for Clojure completions using nrepl.el."
  (interactive)
  (when (null (ignore-errors (nrepl-current-session)))
    (error "An active nrepl session is required for helm completion"))
  (let* ((initial-pattern (nrepl-symbol-at-point))
         (beg (- (point) (length initial-pattern)))
         (end (point)))
    (with-helm-show-completion beg end
      (helm 'helm-source-nrepl initial-pattern))))

(provide 'helm-nrepl)


;;; helm-nrepl.el ends here


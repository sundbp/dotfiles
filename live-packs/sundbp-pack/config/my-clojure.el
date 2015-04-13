;;(require 'clojure-test-mode)

(add-hook 'clojure-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(FIXME\\|TODO\\|BUG\\|NOTE\\):" 1 font-lock-warning-face t)))))

(define-clojure-indent
  (expect 'defun)
  (expect-let 'defun)
  (expect-focused 'defun)
  (expect-let-focused 'defun)
  (given 'defun)
  (context 1)
  (freeze-time 1)
  (redef-state 1)
  (from-each 1))

(dolist (x '((true        т)
             (false       ғ)
             (nil         Ø)
             (with-redefs я)
             (interaction ι)
             (a-fn1       α)
             (a-fn2       β)
             (a-fn3       γ)
             (no-op       ε)))
  (eval-after-load 'clojure-mode
    '(font-lock-add-keywords
      'clojure-mode `((,(concat "[\[({[:space:]]"
                                "\\(" (symbol-name (first x)) "\\)"
                                "[\])}[:space:]]")
                       (0 (progn (compose-region (match-beginning 1)
                                                 (match-end 1) ,(symbol-name (second x)))
                                 nil))))))
  (eval-after-load 'clojure-mode
    '(font-lock-add-keywords
      'clojure-mode `((,(concat "^"
                                "\\(" (symbol-name (first x)) "\\)"
                                "[\])}[:space:]]")
                       (0 (progn (compose-region (match-beginning 1)
                                                 (match-end 1) ,(symbol-name (second x)))
                                 nil))))))
  (eval-after-load 'clojure-mode
    '(font-lock-add-keywords
      'clojure-mode `((,(concat "[\[({[:space:]]"
                                "\\(" (symbol-name (first x)) "\\)"
                                "$")
                       (0 (progn (compose-region (match-beginning 1)
                                                 (match-end 1) ,(symbol-name (second x)))
                                 nil)))))))

(defun test-full-path (project-root test-home)
  (concat
   (replace-regexp-in-string
    (concat (expand-file-name project-root) "src")
    (concat project-root test-home)
    (file-name-sans-extension (buffer-file-name)))
   "_test.clj"))

(defun find-tests ()
  (interactive)
  (let* ((project-root (locate-dominating-file
                         (file-name-directory (buffer-file-name)) "project.clj")))
    (if project-root
        (let* ((full-path-with-clojure (test-full-path project-root
                                                       "test")))
          (if (file-exists-p full-path-with-clojure)
              (set-window-buffer (next-window) (find-file-noselect full-path-with-clojure))
            (message (concat "cound not find " full-path-with-clojure))))
      (message (concat "no project.clj found at or below " (buffer-file-name))))))

(defun src-full-path (project-root file-name)
  (concat
   (replace-regexp-in-string
    (concat (expand-file-name project-root) "test")
    (concat project-root "src")
    (file-name-directory file-name))
   (replace-regexp-in-string
    "_test"
    ""
    (file-name-nondirectory file-name))))

(defun find-src ()
  (interactive)
  (let* ((project-root (locate-dominating-file
                         (file-name-directory (buffer-file-name)) "project.clj")))
    (if project-root
        (let* ((full-path (src-full-path project-root (buffer-file-name))))
          (if (file-exists-p full-path)
              (set-window-buffer (next-window) (find-file-noselect full-path))
            (message (concat "cound not find " full-path))))
      (message (concat "no project.clj found at or below " (buffer-file-name))))))

(defun toggle-test-impl ()
  (interactive)
  (if (string-match ".*_test.clj" (buffer-file-name))
      (find-src)
    (find-tests)))

(setenv "EXPECTATIONS_SHOW_RAW" "false")

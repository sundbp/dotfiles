;;; cider-inspect.el --- Object inspector for Cider on Emacs

;; Copyright © 2013 Vital Reactor, LLC

;; Author: Ian Eslick <ian@vitalreactor.com>
;; URL: http://www.github.com/vitalreactor/cider-inspect
;; Version: 0.4.0
;; Keywords: languages, clojure, cider, nrepl
;; Package-Requires: ((clojure-mode "2.0.0") (cider "0.4.0"))

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file is not part of GNU Emacs.

(require 'cl)
(require 'cider)

;; ===================================
;; Inspector Key Map and Derived Mode
;; ===================================

(defvar cider-inspector-mode-map
  (let ((map (make-sparse-keymap)))
	(define-key map [return] 'cider-inspector-operate-on-point)
	(define-key map "\C-m"   'cider-inspector-operate-on-point)
	(define-key map [mouse-1] 'cider-inspector-operate-on-click)
	(define-key map "l" 'cider-inspector-pop)
;;	(define-key map "n" 'nrepl-inspector-next)
;;	(define-key map " " 'nrepl-inspector-next)
;;  ("d" 'nrepl-inspector-describe)
;;  ("p" 'nrepl-inspector-pprint)
;;  ("e" 'nrepl-inspector-eval)
;;  ("h" 'slime-inspector-history)
;;  ("v" 'slime-inspector-toggle-verbose)
    (define-key map "g" 'cider-inspector-refresh)
	(define-key map [tab] 'cider-inspector-next-inspectable-object)
	(define-key map "\C-i" 'cider-inspector-next-inspectable-object)
	(define-key map [(shift tab)] 
	  'cider-inspector-previous-inspectable-object) ; Emacs translates S-TAB
	(define-key map [backtab] 'cider-inspector-previous-inspectable-object) ; to BACKTAB on X.
;;  ("." 'nrepl-inspector-show-source)
;;  (">" 'nrepl-inspector-fetch-all)
	map))

(set-keymap-parent cider-inspector-mode-map cider-popup-buffer-mode-map)

(define-minor-mode cider-inspector-buffer-mode
  "nREPL Inspector Buffer Mode."
  nil
  (" nREPL Inspector")
  cider-inspector-mode-map
  (set-syntax-table clojure-mode-syntax-table)
  (setq buffer-read-only t)
  (set (make-local-variable 'truncate-lines) t))

;; 
;; Top level
;;

(defvar cider-minibuffer-map
  (let ((map (make-sparse-keymap)))
	(set-keymap-parent map minibuffer-local-map)
	(define-key map "\t" 'completion-at-point)
	(define-key map "\M-\t" 'completion-at-point)
	map))

(defun cider-inspect (string)
  "Eval an expression and inspect the result"
  (interactive
   (list (read-from-minibuffer "Inspect value (evaluated): "
							   (or (cider-sexp-at-point)
								   (save-excursion
									 (unless (equal (string (char-before)) " ")
									   (backward-char)
									   (cider-sexp-at-point))))
							   cider-minibuffer-map
							   nil '())))
  (cider-inspect-sym string (cider-current-ns)))

(defun cider-inspect-debug (output)
  (with-current-buffer (get-buffer-create "cider-inspect-debug")
	(cider-inspector-buffer-mode 1)
    (if (= (point) (point-max))
        (insert output))
    (save-excursion
      (goto-char (point-max))
      (insert output))))


;; Operations
(defun cider-render-response (buffer)
  (nrepl-make-response-handler
   buffer
   (lambda (buffer str)
	 (cider-irender buffer str))
   '()
   (lambda (buffer str)
	 (cider-emit-into-popup-buffer buffer "Oops"))
   '()))

(defun cider-inspect-sym (sym ns)
  (let ((buffer (cider-popup-buffer "*cider inspect*" t)))
	(nrepl-send-request (list "op" "inspect-start" "sym" sym "ns" ns)
						(cider-render-response buffer))))

(defun cider-inspector-pop ()
  (interactive)
  (let ((buffer (cider-popup-buffer "*cider inspect*" t)))
	(nrepl-send-request (list "op" "inspect-pop")
						(cider-render-response buffer))))

(defun cider-inspector-push (idx)
  (let ((buffer (cider-popup-buffer "*cider inspect*" t)))
	(nrepl-send-request (list "op" "inspect-push" "idx" (number-to-string idx))
						(cider-render-response buffer))))

(defun cider-inspector-refresh ()
  (interactive)
  (let ((buffer (cider-popup-buffer "*cider inspect*" t)))
	(nrepl-send-request (list "op" "inspect-refresh")
						(cider-render-response buffer))))

(defun cider-test ()
  (cider-inspect-sym "testing" "inspector.javert"))


;; Utilities
(defmacro cider-propertize-region (props &rest body)
  "Execute BODY and add PROPS to all the text it inserts.
More precisely, PROPS are added to the region between the point's
positions before and after executing BODY."
  (let ((start (gensym)))
    `(let ((,start (point)))
       (prog1 (progn ,@body)
		 (add-text-properties ,start (point) ,props)))))


;; Render Inspector from Structured Values
(defun cider-irender (buffer str)
  (with-current-buffer buffer
    (cider-inspector-buffer-mode 1)
	(let ((inhibit-read-only t))
	  (condition-case nil
		  (cider-irender* (car (read-from-string str)))
		(error (newline) (insert "Inspector error for: " str))))
	(goto-char (point-min))))

(defun cider-irender* (elements)
  (setq cider-irender-temp elements)
  (dolist (el elements)
	(cider-irender-el* el)))

(defun cider-irender-el* (el)
  (cond ((symbolp el) (insert (symbol-name el)))
		((stringp el) (insert el))
		((and (consp el) (eq (car el) :newline))
		 (newline))
		((and (consp el) (eq (car el) :value))
		 (cider-irender-value (cadr el) (caddr el)))
		(t (message "Unrecognized inspector object: " el))))

(defun cider-irender-value (value idx)
  (cider-propertize-region
	  (list 'cider-value-idx idx
			'mouse-face 'highlight
			'face 'font-lock-keyword-face)
	(cider-irender-el* value)))


;; ===================================================
;; Inspector Navigation (lifted from SLIME inspector)
;; ===================================================

(defun cider-find-inspectable-object (direction limit)
  "Find the next/previous inspectable object.
DIRECTION can be either 'next or 'prev.  
LIMIT is the maximum or minimum position in the current buffer.

Return a list of two values: If an object could be found, the
starting position of the found object and T is returned;
otherwise LIMIT and NIL is returned."
  (let ((finder (ecase direction
                  (next 'next-single-property-change)
                  (prev 'previous-single-property-change))))
    (let ((prop nil) (curpos (point)))
      (while (and (not prop) (not (= curpos limit)))
        (let ((newpos (funcall finder curpos 'cider-value-idx nil limit)))
          (setq prop (get-text-property newpos 'cider-value-idx))
          (setq curpos newpos)))
      (list curpos (and prop t)))))

(defun cider-inspector-next-inspectable-object (arg)
  "Move point to the next inspectable object.
With optional ARG, move across that many objects.
If ARG is negative, move backwards."
  (interactive "p")
  (let ((maxpos (point-max)) (minpos (point-min))
        (previously-wrapped-p nil))
    ;; Forward.
    (while (> arg 0)
      (destructuring-bind (pos foundp)
          (cider-find-inspectable-object 'next maxpos)
        (if foundp
            (progn (goto-char pos) (setq arg (1- arg))
                   (setq previously-wrapped-p nil))
            (if (not previously-wrapped-p) ; cycle detection
                (progn (goto-char minpos) (setq previously-wrapped-p t))
                (error "No inspectable objects")))))
    ;; Backward.
    (while (< arg 0)
      (destructuring-bind (pos foundp)
          (cider-find-inspectable-object 'prev minpos)
        ;; CIDER-OPEN-INSPECTOR inserts the title of an inspector page
        ;; as a presentation at the beginning of the buffer; skip
        ;; that.  (Notice how this problem can not arise in ``Forward.'')
        (if (and foundp (/= pos minpos))
            (progn (goto-char pos) (setq arg (1+ arg))
                   (setq previously-wrapped-p nil))
            (if (not previously-wrapped-p) ; cycle detection
                (progn (goto-char maxpos) (setq previously-wrapped-p t))
                (error "No inspectable objects")))))))

(defun cider-inspector-previous-inspectable-object (arg)
  "Move point to the previous inspectable object.
With optional ARG, move across that many objects.
If ARG is negative, move forwards."
  (interactive "p")
  (cider-inspector-next-inspectable-object (- arg)))

(defun cider-inspector-property-at-point ()
  (let* ((properties '(cider-value-idx cider-range-button
									   cider-action-number))
         (find-property
          (lambda (point)
            (loop for property in properties
                  for value = (get-text-property point property)
                  when value
                  return (list property value)))))
      (or (funcall find-property (point))
          (funcall find-property (1- (point))))))

(defun cider-inspector-operate-on-point ()
  "Invoke the command for the text at point.
1. If point is on a value then recursivly call the inspector on
that value.  
2. If point is on an action then call that action.
3. If point is on a range-button fetch and insert the range."
  (interactive)
  (destructuring-bind (property value)
	  (cider-inspector-property-at-point)
	(case property
	  (cider-value-idx
	   (cider-inspector-push value))
	  ;; TODO: range and action handlers 
	  (t (error "No object at point")))))

(defun cider-inspector-operate-on-click (event)
  "Move to events' position and operate the part."
  (interactive "@e")
  (let ((point (posn-point (event-end event))))
    (cond ((and point
                (or (get-text-property point 'cider-value-idx)))
;;                    (get-text-property point 'cider-range-button)
;;                    (get-text-property point 'cider-action-number)))
           (goto-char point)
           (slime-inspector-operate-on-point))
          (t
           (error "No clickable part here")))))

(provide 'cider-inspect)

;;; cider-inspect.el ends here
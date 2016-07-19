(custom-set-variables
 '(safe-local-variable-values
   '((encoding . utf-8)
     )))

;;; elpy
;; (elpy-enable)
;; (elpy-use-ipython)

;; python-mode
(autoload 'python-mode "python-mode" "Python editing mode." t)
(add-hook 'python-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode nil)
	     (setq indent-level 4)
	     (setq python-indent 4)
	     (setq tab-width 4)))

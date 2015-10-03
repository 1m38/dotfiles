(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
    '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

(global-set-key (kbd "<f12>") 'flyspell-mode)
(global-set-key (kbd "<f10>") 'flyspell-buffer)
(global-set-key (kbd "<f9>") 'ispell-word)

;; flyspell-mode
(mapc
 (lambda (hook)
   (add-hook hook 'flyspell-prog-mode))
 '(
   c++-mode-hook
   emacs-lisp-mode-hook
   ruby-mode-hook
   python-mode-hook
   ))
(mapc
 (lambda (hook)
   (add-hook hook
	     '(lambda () (flyspell-mode 1))))
 '(
   yatex-mode-hook
   ))

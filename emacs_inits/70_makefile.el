;; Emacs 21 以降で Makefile の編集時に "Suspicious line XXX. Save anyway"
;; というプロンプトを出さないようにするためのおまじない
;; http://www.bookshelf.jp/soft/meadow_24.html
(add-hook 'makefile-mode-hook
	  (function
	   (lambda ()
	     (fset 'makefile-warn-suspicious-lines 'ignore))))

(add-hook 'c-mode-common-hook
	  '(lambda ()
	     ;; センテンスの終了である ';' を入力したら、自動改行+インデント
	     (c-toggle-auto-hungry-state 1)))

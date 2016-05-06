;;; プレフィクスキーはC-z
(global-unset-key (kbd "C-z"))
(setq elscreen-prefix-key (kbd "C-z"))
(elscreen-start)
;;; タブの先頭に[X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;;; header-lineの先頭に[<->]を表示しない
(setq elscreen-tab-display-control nil)
;;; バッファ名・モード名からタブに表示させる内容を決定する(デフォルト設定)
(setq elscreen-buffer-to-nickname-alist
      '(("^dired-mode$" .
	 (lambda ()
	   (format "Dired(%s)" dired-directory)))
	("^Info-mode$" .
	 (lambda ()
	   (format "Info(%s)" (file-name-nondirectory Info-current-file))))
	("^mew-draft-mode$" .
	 (lambda ()
	   (format "Mew(%s)" (buffer-name (current-buffer)))))
	("^mew-" . "Mew")
	("^irchat-" . "IRChat")
	("^liece-" . "Liece")
	("^lookup-" . "Lookup")))
(setq elscreen-mode-to-nickname-alist
      '(("[Ss]hell" . "shell")
	("compilation" . "compile")
	("-telnet" . "telnet")
	("dict" . "OnlineDict")
	("*WL:Message*" . "Wanderlust")))

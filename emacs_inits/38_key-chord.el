;;;key-chord 初期設定
(require 'key-chord)
(key-chord-mode 1)


;;; key-chord/key-comboなど、
;;; 端末越しペーストで邪魔になるキーバインド無効化
(defun my_key-assist-diable ()
  "端末越しペーストで邪魔になるモードを無効化する。
\n対象: key-chord, key-combo"
  (interactive)
  (let* (new-mode-status)
    (setq new-mode-status
	    (cond (key-chord-mode -1)
		  (key-combo-mode -1)
		  (t 1)
		  ))
    (key-chord-mode new-mode-status)
    (global-key-combo-mode new-mode-status)
    (if (not (equal new-mode-status -1))
      (message "key-chord-mode / key-combo-mode enabled.")
      (message "key-chord-mode / key-combo-mode disabled.")
      )))


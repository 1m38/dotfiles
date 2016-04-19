; 行番号を表示する
(global-linum-mode t)
(setq linum-format "%4d|")
; 現在の行番号を目立たせる
(el-get-bundle! tom-tan/hlinum-mode)
(hlinum-activate)

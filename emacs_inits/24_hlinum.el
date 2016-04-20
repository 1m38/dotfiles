; 行番号を表示する
(global-linum-mode t)
;; http://d.hatena.ne.jp/daimatz/20120215/1329248780
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
    (run-with-idle-timer 0.02 nil #'linum-update-current))
(setq linum-format "%4d|")
; 現在の行番号を目立たせる
(el-get-bundle! tom-tan/hlinum-mode)
(hlinum-activate)

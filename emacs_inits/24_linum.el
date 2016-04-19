; 行番号を表示する
(global-linum-mode t)
(setq linum-format "%4d|")
; 現在の行番号を目立たせる
;; (el-get-bundle! tom-tan/hlinum-mode)
;; (hlinum-activate)

; git-gutter
(require 'git-gutter)
(global-git-gutter-mode t)
(git-gutter:linum-setup)
(custom-set-variables
  '(git-gutter:update-interval 5))


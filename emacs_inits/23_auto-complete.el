(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;; auto-completeが起動しないモードがあったら以下に追加
(add-to-list 'ac-modes 'yatex-mode)

;; 空白や長すぎる行を視覚化する。
;; http://www.clear-code.com/blog/2012/3/20.html
(require 'whitespace)
;; 1行が80桁を超えたら長すぎると判断する。
(setq whitespace-line-column 80)
(setq whitespace-style '(face
			 trailing
			 lines-tail
			 space-before-tab
			 space-after-tab))
;; デフォルトで視覚化を有効にする。
(global-whitespace-mode 1)
  


;; http://rubikitch.com/2015/03/10/shackle/
(require 'shackle)
(setq shackle-rules
      '(;; *compilation*は下部に2割の大きさで表示
	(compilation-mode :align below :ratio 0.2)
	;; ヘルプバッファは右側に表示
	("*Help*" :align right)
	;; 補完バッファは下部に3割の大きさで表示
	("*Completions*" :align below :ratio 0.3)
	;; M-x helm-miniは下部に7割の大きさで表示
	("*helm mini*" :align below :ratio 0.7)
	("*helm for files*" :align below :ratio 0.7)
	;; 他のhelmコマンドは右側に表示 (バッファ名の正規表現マッチ)
	;; ("\*helm" :regexp t :align right)
	("\*helm" :regexp t :align below :ratio 0.5)
	;; ;; 上部に表示
	;; ("foo" :align above)
	;; ;; 別フレームで表示
	;; ("bar" :frame t)
	;; ;; 同じウィンドウで表示
	;; ("baz" :same t)
	;; ;; ポップアップで表示
	;; ("hoge" :popup t)
	;; ;; 選択する
	;; ("abc" :select t)
	))
(shackle-mode 1)
(setq shackle-lighter "")

;; diredを2つのウィンドウで開いているときに、デフォルトの移動・コピー先をもう一方で開いているディレクトリにする
(setq dired-dwim-target t)
;; ディレクトリを再帰的にコピーする
(setq dired-recursive-copies 'always)
;; diredバッファでC-sした時にファイル名だけにマッチするように
(setq dired-isearch-filenames t)
;; dired実行時のコマンドを "ls -Ahl" に変更
(setq dired-listing-switches (purecopy "-Ahl"))

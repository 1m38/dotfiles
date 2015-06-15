;; 各種設定ファイルに色をつける
(require 'generic-x)

;; mode-line調整
(size-indication-mode t)
;(display-time-mode t)
;(setq display-time-format "%m/%d(%a)%H:%M:%S")
(setq mode-line-frame-identification " ")  ;複数フレーム開かない人向け:フレーム番号を表示しない

;; avoid "Symbolic link to SVN-controlled source file; follow link? (yes or no)"
(setq vc-follow-symlinks t)

;; Window 分割を画面サイズに従って計算する
;; http://qiita.com/sho7650/items/7d4a152c08c4f9d4cf14
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))

;; Window 分割・移動を C-t で
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (if (>= (window-body-width) 270)
	(split-window-horizontally-n 3)
      (split-window-horizontally)))
  (other-window 1))
(global-set-key (kbd "C-t") 'other-window-or-split)

;;; 最終行に必ず一行挿入する
(setq require-final-newline t)


;; ファイル名補完で大文字小文字を区別しない
(setq completion-ignore-case t)
;; emacs外でファイルが変更されたら再読込する
;(global-auto-revert-mode 1)

;; 現在行をハイライト(背景色black)
(global-hl-line-mode t)
(custom-set-faces
 '(hl-line ((t (:background "black"))))
 )

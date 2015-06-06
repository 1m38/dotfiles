;; バックアップファイルを作らない(auto-save-buffers-enhanced で代用)
(setq backup-inhibited t)
;; バックアップファイルの作成を完全に無効化
(setq make-backup-files nil)  ; <file>~
(setq auto-save-default nil)  ; #<file>#
(setq auto-save-list-file-prefix nil)  ; #<file># のリスト
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
;; バックアップを~/.emacs.d/backup に作成
;; (setq backup-directory-alist
;;       (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
;;             backup-directory-alist))
;; (setq auto-save-file-name-transforms
;;         `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;; auto-save-buffers-enhanced
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-interval 0.5) ; 指定のアイドル秒で保存
;;; 特定のファイルのみ有効にする
(setq auto-save-buffers-enhanced-include-regexps '(".+")) ;全ファイル
;; not-save-fileと.ignoreは除外する
(setq auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$"))
;;; Wroteのメッセージを抑制
(setq auto-save-buffers-enhanced-quiet-save-p t)
;;; *scratch*も ~/.emacs.d/scratch に自動保存
;; (setq auto-save-buffers-enhanced-save-scratch-buffer-to-file-p t)
;; (setq auto-save-buffers-enhanced-file-related-with-scratch-buffer
;;       (locate-user-emacs-file "scratch"))
(auto-save-buffers-enhanced t)

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

;; real-auto-save
(require 'real-auto-save)
(setq real-auto-save-interval 1)
;; (add-hook 'prog-mode-hook 'real-auto-save-mode)
(add-hook 'find-file-hook 'real-auto-save-mode) ;全ファイル対象

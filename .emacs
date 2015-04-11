;;
;; .emacs (2012/4/16 Kawahara)
;;        (2015/1/27 Kishimoto) 
;;

;;; basic configuration
(menu-bar-mode -1)		   ; menu barを表示しない
(if window-system                  ; "Symbol's function definition is void" 対策(2015/1/27 修正)
    ((tool-bar-mode -1)		   ; tool barを表示しない
     (set-scroll-bar-mode 'right)  ; scroll barを右へ
))
(line-number-mode 1)		   ; cursorの行数を表示
(column-number-mode 1)		   ; cursorの行頭からの文字数を表示
(global-font-lock-mode t)	   ; 色付
(show-paren-mode t)		   ; 括弧の対応を表示
(transient-mark-mode t)		   ; enable visual feedback on selections
(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-h" 'delete-backward-char)

;;; shell mode
(ansi-color-for-comint-mode-on) ; 色をつける
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt) ; パスワードを伏字にする
(add-hook 'comint-mode-hook	; M-pで履歴を補完
	  (lambda ()
	    (define-key comint-mode-map "\M-p" 'comint-previous-matching-input-from-input)
	    (define-key comint-mode-map "\M-n" 'comint-next-matching-input-from-input)
	    ))

;;; YaTeX
(setq load-path (cons (expand-file-name "/usr/share/emacs/site-lisp/yatex") load-path))
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq load-path (cons (expand-file-name "~/src/emacs/yatex") load-path))
(setq YaTeX-kanji-code 4	; utf-8
      YaTeX-use-AMS-LaTeX t
      YaTeX-use-LaTeX2e t)
(setq tex-command "platex"
      dvi2-command "pxdvi"
      dviprint-command-format "pdvips -f %f %t %s | lpr"
      dviprint-from-format "-p %b"
      dviprint-to-format "-l %e"
      section-name "documentclass")

;;; ispell (日本語でとまらないように)
(eval-after-load "ispell"
  '(setq ispell-skip-region-alist (cons '("[^A-Za-z0-9 -]+")
                                        ispell-skip-region-alist)))

;;; M-x ps-print-bufferで印刷するときに文字化けしないように
(require 'ps-mule)
(defalias 'ps-mule-header-string-charsets 'ignore)
(setq ps-multibyte-buffer `non-latin-printer
      ps-print-color-p t
      ps-print-only-one-header t
      ps-paper-type 'a4
      ps-n-up-printing 2
      ps-n-up-border-p nil)


;;======== 個人設定 ========
(require 'generic-x)

; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/elpa")

; 起動時にInstallされていないelispをpackage.elで自動インストール
; http://kei10in.hatenablog.jp/entry/2012/09/12/220833
(require 'cl)
(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    auto-install
    auto-complete
    magit
    key-chord
    ))
(let ((not-installed (loop for x in installing-package-list
			   when (not (package-installed-p x))
			   collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
                    (package-install pkg))))


; auto-install
(add-to-list 'load-path "~/.emacs.d/auto-install")
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
;(auto-install-update-emacswiki-package-name t)

; anything
(require 'anything-startup)
; key-chord 初期設定
(require 'key-chord)
(key-chord-mode 1)
; magit
(require 'magit)
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")  ;起動時メッセージを表示しない
(set-face-foreground 'magit-diff-add "white")
(set-face-background 'magit-item-highlight "green")

; auto-complete
(require 'auto-complete-config)
(global-auto-complete-mode t)


; バックアップファイルを作らない
(setq backup-inhibited t)
; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; バッファの同一ファイル名を区別する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

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
;;; 最終行に必ず一行挿入する
(setq require-final-newline t)


; 行番号を表示する
(global-linum-mode t)
; 現在の行番号を目立たせる
(require 'hlinum)
(hlinum-activate)




; key-chord キーマップ
(key-chord-define-global "af" 'anything)
(key-chord-define-global "df" 'descbinds-anything)
(key-chord-define-global "xf" 'anything-filelist+)

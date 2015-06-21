;;
;; .emacs (2012/4/16 Kawahara)
;;        (2015/1/27 Kishimoto) 
;;

;;; basic configuration
(menu-bar-mode -1)		   ; menu barを表示しない
(if window-system (progn           ; "Symbol's function definition is void" 対策(2015/1/27 修正)
    (tool-bar-mode -1)		   ; tool barを表示しない
    (set-scroll-bar-mode 'right)   ; scroll barを右へ
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
;;; 65_yatex.el に移動

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

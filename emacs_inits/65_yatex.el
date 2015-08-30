;;; YaTeX
;(setq load-path (cons (expand-file-name "/usr/share/emacs/site-lisp/yatex") load-path))
;(setq load-path (cons (expand-file-name "~/.emacs.d/site-lisp/yatex1.78.4") load-path))
;(setq auto-mode-alist
;      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
;; http://ksknw.hatenablog.com/entry/2015/02/11/202320
(setq auto-mode-alist (append
		       '(("\\.tex$" . yatex-mode)
			 ("\\.ltx$" . yatex-mode)
			 ("\\.cls$" . yatex-mode)
			 ("\\.sty$" . yatex-mode)
			 ("\\.clo$" . yatex-mode)
			 ("\\.bbl$" . yatex-mode)) auto-mode-alist))
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



;; http://ksknw.hatenablog.com/entry/2015/02/11/202320
;; 自動改行を抑制 これがないと長い文章のよくわからないところで改行される
(add-hook ' yatex-mode-hook
	    '(lambda () (auto-fill-mode -1)))

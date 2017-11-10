;;; YaTeX
(setq load-path (cons (expand-file-name "~/src/emacs/yatex") load-path))
;; http://ksknw.hatenablog.com/entry/2015/02/11/202320
(setq auto-mode-alist (append
		       '(("\\.tex$" . yatex-mode)
			 ("\\.ltx$" . yatex-mode)
			 ("\\.cls$" . yatex-mode)
			 ("\\.sty$" . yatex-mode)
			 ("\\.clo$" . yatex-mode)
			 ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq YaTeX-kanji-code 4	; utf-8
      YaTeX-use-AMS-LaTeX t
      YaTeX-use-LaTeX2e t)
(setq tex-command "latexmk"
      section-name "documentclass")
(cond ((equal system-type 'darwin)
       (setq dvi2-command "reattach-to-user-namespace open -a skim"))
      ((equal system-type 'gnu-linux)
       (setq dvi2-command "evince")))


;; http://ksknw.hatenablog.com/entry/2015/02/11/202320
;; 自動改行を抑制 これがないと長い文章のよくわからないところで改行される
(add-hook ' yatex-mode-hook
	    '(lambda () (auto-fill-mode -1)))


(defvar YaTeX-dvi2-command-ext-alist
  '(("acroread\\|pdf\\|Preview\\|TeXShop\\|Skim\\|evince\\|apvlv\\|open" . ".pdf")))

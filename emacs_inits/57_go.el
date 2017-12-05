;; https://qiita.com/bussorenre/items/3e80e59d517db8aebf46

;; Go path
(add-to-list 'exec-path (expand-file-name "~/.anyenv/envs/goenv/shims/"))
;; user $GOPATH
(add-to-list 'exec-path (expand-file-name "~/.go/bin/"))

(require 'go-mode)
(require 'company-go)

(add-hook 'go-mode-hook (lambda()
			  (add-hook 'before-save-hook' 'gofmt-before-save)
			  (local-set-key (kbd "M-.") 'godef-jump)
			  (set (make-local-variable 'company-backends) '(company-go))
			  (company-mode)
			  (setq indent-tabs-mode nil)    ; タブを利用
			  (setq c-basic-offset 4)        ; tabサイズを4にする
			  (setq tab-width 4)))

(custom-set-variables
 '(safe-local-variable-values
   '((encoding . utf-8)
     )))

;;; elpy
(elpy-enable)
(elpy-use-ipython)
(elpy-clean-modeline)
;; autopep8
;; http://qiita.com/fujimisakari/items/74e32eddb78dff4be585
;; source: github:fujimisakari/py-autopep8.el
(el-get-bundle! py-autopep8
    :type github :pkgname "fujimisakari/py-autopep8.el")
(add-hook 'python-mode-hook
	  (lambda ()
	    (define-key python-mode-map (kbd "C-c F") 'py-autopep8)          ; バッファ全体のコード整形
	    (define-key python-mode-map (kbd "C-c f") 'py-autopep8-region)   ; 選択リジョン内のコード整形
	    ))

;; 保存時にバッファ全体を自動整形する
;; (add-hook 'before-save-hook 'py-autopep8-before-save)

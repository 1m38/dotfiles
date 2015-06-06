(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
;(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
; css
;(setq markdown-css-path "/home/masaya/Dropbox/markdown.css")
(custom-set-variables
  '(markdown-css-paths '("/home/masaya/Dropbox/markdown.css")))


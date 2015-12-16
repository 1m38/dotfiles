;; source: https://raw.githubusercontent.com/antonj/Highlight-Indentation-for-Emacs/master/highlight-indentation.el
;; reference: http://blog.iss.ms/2012/03/17/095152
(el-get-bundle! highlight-indentation
    :type github :pkgname "antonj/Highlight-Indentation-for-Emacs"
    :features highlight-indentation)

(set-face-background 'highlight-indentation-face "color-238")
(set-face-background 'highlight-indentation-current-column-face "color-242")

(add-hook 'python-mode-hook 'highlight-indentation-mode)
;(add-hook 'python-mode-hook 'highlight-indentation-current-column-mode)


;;; el-get
;; 指定されたディレクトリを.emacs.dとして利用
;; $ emacs -q -l ~/path/to/somewhere/init.el
;; ref: http://d.hatena.ne.jp/tarao/20150221/1424518030#tips-isolated-setup
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))


;;; package, init-loader
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize)
  (unless (package-installed-p 'init-loader)
    (package-refresh-contents)
    (package-install 'init-loader))
  (require 'init-loader)
  (init-loader-load (concat user-emacs-directory "inits"))
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-ghc-show info)
 '(markdown-css-paths (quote ("markdown.css")))
 '(package-selected-packages
   (quote
    (nlinum yatex nav helm-flycheck flycheck key-combo helm-descbinds helm-ls-git helm real-auto-save markdown-mode emmet-mode rhtml-mode smartparens key-chord magit company auto-install init-loader)))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-selection ((t (:background "magenta" :distant-foreground "black"))))
 '(hl-line ((t (:background "black"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#6faeef"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#69cd69"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#ef6f6f"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#efc300"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#9d9de8"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#c99a9a"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#69cd69"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#9d9de8"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#c28d8d"))))
 '(rainbow-delimiters-mismatched-face ((t (:foreground "#88090b"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "#88090b"))))
 '(sp-pair-overlay-face ((t nil))))

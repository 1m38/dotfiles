(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize)
  (unless (package-installed-p 'init-loader)
    (package-refresh-contents)
    (package-install 'init-loader))
  (require 'init-loader)
  (init-loader-load "~/.emacs.d/inits")
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(custom-safe-themes
 ;;   (quote
 ;;    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(markdown-css-paths (quote ("markdown.css")))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-selection ((t (:background "magenta" :distant-foreground "black"))))
 '(hl-line ((t (:background "black")))))

(when (locate-library "ess-site")
  (load "ess-site"))
(setq auto-mode-alist
      (cons (cons "\\.[rR]$" 'R-mode) auto-mode-alist))
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)

;; R 起動時にワーキングディレクトリを訊ねない
(setq ess-ask-for-ess-directory nil)

;; auto-complete
(setq ess-use-auto-complete t)

(define-key ess-mode-map (kbd "C-c v") 'ess-R-dv-pprint)

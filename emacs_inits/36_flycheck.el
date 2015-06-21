;;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; helm-flycheck
(require 'helm-flycheck)
(define-key flycheck-mode-map (kbd "C-c 1") 'helm-flycheck)

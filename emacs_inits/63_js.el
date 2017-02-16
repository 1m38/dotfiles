(add-to-list 'auto-mode-alist '("\.js$" . js2-mode))
(add-hook 'js2-mode-hook 'tern-mode)

;; company-tern
(add-to-list 'company-backends 'company-tern)
(setq company-tern-property-marker nil)
(setq company-tern-meta-as-single-line t)


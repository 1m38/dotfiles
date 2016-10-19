(require 'smartparens-config)
;; http://qiita.com/ShingoFukuyama/items/ed1af137a98e0028e025
(smartparens-global-mode t)
(ad-disable-advice 'delete-backward-char 'before 'sp-delete-pair-advice)
(ad-activate 'delete-backward-char)

;; カッコ挿入時、カッコ内をハイライトしない
(custom-set-faces
 '(sp-pair-overlay-face ((t nil))))

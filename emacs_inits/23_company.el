(global-company-mode +1)
(setq company-idle-delay 0.5)
(setq company-minimum-prefix-length 2)
; 候補の一番下でさらに下に行こうとすると一番上に戻る
(setq company-selection-wrap-around t)

;; TABの挙動変更
;; http://qiita.com/sune2/items/b73037f9e85962f5afb7
(defun company--insert-candidate2 (candidate)
  (when (> (length candidate) 0)
    (setq candidate (substring-no-properties candidate))
    (if (eq (company-call-backend 'ignore-case) 'keep-prefix)
	(insert (company-strip-prefix candidate))
      (if (equal company-prefix candidate)
	  (company-select-next)
	(delete-region (- (point) (length company-prefix)) (point))
	(insert candidate))
      )))

(defun company-complete-common2 ()
  (interactive)
  (when (company-manual-begin)
    (if (and (not (cdr company-candidates))
	     (equal company-common (car company-candidates)))
	(company-complete-selection)
      (company--insert-candidate2 company-common))))


;; 色設定
;; http://qiita.com/syohex/items/8d21d7422f14e9b53b17
(set-face-attribute 'company-tooltip nil
		    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common nil
		    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common-selection nil
		    :foreground "white" :background "steelblue")
(set-face-attribute 'company-tooltip-selection nil
		    :foreground "black" :background "steelblue")
(set-face-attribute 'company-preview-common nil
		    :background nil :foreground "lightgrey" :underline t)
(set-face-attribute 'company-scrollbar-fg nil
		    :background "orange")
(set-face-attribute 'company-scrollbar-bg nil
		    :background "gray40")

;; key-binding
(define-key company-active-map [tab] 'company-complete-common2)
(define-key company-active-map [backtab] 'company-select-previous)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "M-m") 'company-complete-selection)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)


;; haskell: ghc-mod連携
(add-to-list 'company-backends 'company-ghc)
(custom-set-variables '(company-ghc-show info t))

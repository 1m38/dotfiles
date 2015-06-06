;;;研究室標準
(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-h" 'delete-backward-char)

;; Window 分割・移動を C-t で (02_basics.el)
(global-set-key (kbd "C-t") 'other-window-or-split)

;; magit
(global-set-key "\C-x\C-m" 'magit-status)  ; C-x C-m でmagit-status起動

;; helm
(define-key global-map (kbd "M-x")     'helm-M-x)
;(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)

(key-chord-define-global "af" 'helm-for-files)
(key-chord-define-global "df" 'helm-descbinds)
(key-chord-define-global "xf" 'helm-browse-project)

;;; key-chord
;; C-x C-k k でkey-chord-mode on/off切り替え
(global-set-key "\C-x\C-kk" 'key-chord-mode)

;;; auto-save-buffers-enhanced
;;; C-x a sでauto-save-buffers-enhancedの有効・無効をトグル
(global-set-key "\C-xas" 'auto-save-buffers-enhanced-toggle-activity)

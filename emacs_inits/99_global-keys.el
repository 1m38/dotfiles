;;;研究室標準
(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-h" 'delete-backward-char)

;; suspend frame (C-z) を無効
(global-unset-key (kbd "C-z"))

;; Window 分割・移動を C-t で (02_basics.el)
(global-set-key (kbd "C-t") 'other-window-or-split)

;; C-x SPC で矩形選択(cua版に変更)
(global-set-key (kbd "C-x SPC") 'cua-rectangle-mark-mode)

;; magit
(global-set-key "\C-c m" 'magit-status)  ; C-c SPC m でmagit-status起動

;; helm
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)

(key-chord-define-global "af" 'helm-for-files)
(key-chord-define-global "df" 'helm-descbinds)
(key-chord-define-global "xf" 'helm-browse-project)

;;; key-chord/key-combo
;; C-z C-k で上記mode on/off切り替え
(global-set-key (kbd "C-z C-k") 'my_key-assist-diable)


;;; auto-save-buffers-enhanced
;;; C-x a sでauto-save-buffers-enhancedの有効・無効をトグル
(global-set-key "\C-xas" 'auto-save-buffers-enhanced-toggle-activity)

;;; nav
(global-set-key (kbd "C-x C-d") 'nav-toggle)

;;; comment-dwim
(global-set-key (kbd "C-\\") 'comment-dwim)

;;; open-junk-file
(global-set-key (kbd "C-x j") 'open-junk-file)

;;; ack
(global-set-key (kbd "C-x g") 'ack)

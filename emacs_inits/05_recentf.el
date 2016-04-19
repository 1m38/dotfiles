;; http://qiita.com/catatsuy/items/f9fad90fa1352a4d3161
;; 自動保存
(when (require 'recentf-ext nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer (run-with-idle-timer 15 t 'recentf-save-list))
  (recentf-mode 1))

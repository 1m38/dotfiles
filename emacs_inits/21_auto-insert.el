;; ref: http://d.hatena.ne.jp/yutoichinohe/20130607/1370627890
(require 'autoinsert)
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory "~/.emacs.d/inits/autoinsert_template/")

;; ref: https://github.com/uwabami/emacs/blob/master/config/auto-insert_config.org
(defvar my:autoinsert-template-replace-alist
  '(("%file%" .
     (lambda()
       (file-name-nondirectory (buffer-file-name))))
    ("%author%" . (lambda()(identity user-full-name)))
    ("%email%"  . (lambda()(identity user-mail-address)))
    ("%filewithoutext%" .
     (lambda()
       (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ))
(defun my:template ()
  (time-stamp)
  (mapc #'(lambda(c)
	    (progn
	      (goto-char (point-min))
	      (replace-string (car c) (funcall (cdr c)) nil)))
	my:autoinsert-template-replace-alist)
  (goto-char (point-max))
    (message "done."))

(setq auto-insert-alist
      (nconc '(
	       ("\\.py$"   .  ["template.py"   my:template])
	       ;; ("\\.el$"   .  ["template.el"   my:template])
	       ;; ("\\.rb$"   .  ["template.rb"   my:template])
	       ;; ("\\.zsh$"  .  ["template.zsh"  my:template])
	       ;; ("\\.sh$"   .  ["template.sh"   my:template])
	       ;; ("\\.f90$"  .  ["template.f90"  my:template])
	       ;; ("\\.cpp$"  .  ["template.cpp"  my:template])
	       ;; ("\\.tex$"  .  ["template.tex"  my:template])
	       ;; ("\\.howm$" .  ["template.howm" my:template])
	       ;; ("\\.org$"  .  ["template.org"  my:template])
	       ;; ("\\.muse$" .  ["template.muse" my:template])
	       ("\\.c$"    .  ["template.c"  my:template])
	       ) auto-insert-alist))

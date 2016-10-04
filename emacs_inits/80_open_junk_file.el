(require 'open-junk-file)

(setq my-junk-file-dir "~/junk")
(setq my-junk-file-format-base (concat my-junk-file-dir "/%Y-%m-%d-%H%M%S"))
(setq open-junk-file-format (concat my-junk-file-format-base "."))
(setq open-junk-file-find-file-function 'find-file)

;;; open-junk-dir (http://handlename.hatenablog.jp/entry/2015/05/04/183405)
(defvar open-junk-dir-format (concat my-junk-file-format-base "_"))

(defun my-open-junk-dir ()
  (interactive)
  (let* ((dir-base (format-time-string open-junk-dir-format (current-time)))
	 (dir (read-string "Dirname: " dir-base)))
    (make-directory dir t)
        (find-file dir)))


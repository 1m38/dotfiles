;;;http://qiita.com/hage@github/items/39ee50df454e2ac6d24b
;;;
;;; ange-ftpがリモートのタイムスタンプ取扱に失敗して、頻繁に
;;; "blahblah changed on disk; really edit the buffer?"
;;; と身に覚えのないことを言ってくるバグを回避するためのパッチ
;;;
;;; cf. http://smallsteps.seesaa.net/archives/200812-1.html
(eval-after-load "ange-ftp"
  '(progn
     (message "patching ange-ftp...")
     (defun ange-ftp-write-region (start end filename &optional append visit)
       (setq filename (expand-file-name filename))
       (let ((parsed (ange-ftp-ftp-name filename)))
         (if parsed
             (let* ((host (nth 0 parsed))
                    (user (nth 1 parsed))
                    (name (ange-ftp-quote-string (nth 2 parsed)))
                    (temp (ange-ftp-make-tmp-name host))
                    ;; What we REALLY need here is a way to determine if the mode
                    ;; of the transfer is irrelevant, i.e. we can use binary mode
                    ;; regardless. Maybe a system-type to host-type lookup?
                    (binary (ange-ftp-binary-file filename))
                    (cmd (if append 'append 'put))
                    (abbr (ange-ftp-abbreviate-filename filename))
                    ;; we need to reset `last-coding-system-used' to its
                    ;; value immediately after calling the real write-region,
                    ;; so that `basic-save-buffer' doesn't see whatever value
                    ;; might be used when communicating with the ftp process.
                    (coding-system-used last-coding-system-used))
               (unwind-protect
                   (progn
                     (let ((filename (buffer-file-name))
                           (mod-p (buffer-modified-p)))
                       (unwind-protect
                           (progn
                             (ange-ftp-real-write-region start end temp nil
                                                         (or visit 'quiet))
                             (setq coding-system-used last-coding-system-used))
                         ;; cleanup forms
                         (setq coding-system-used last-coding-system-used)
                         (setq buffer-file-name filename)
                         (set-visited-file-modtime (ange-ftp-file-modtime filename))
                         (restore-buffer-modified-p mod-p)))
                     (if binary
                         (ange-ftp-set-binary-mode host user))

                     ;; tell the process filter what size the transfer will be.
                     (let ((attr (file-attributes temp)))
                       (if attr
                           (ange-ftp-set-xfer-size host user (nth 7 attr))))

                     ;; put or append the file.
                     (let ((result (ange-ftp-send-cmd host user
                                                      (list cmd temp name)
                                                      (format "Writing %s" abbr))))
                       (or (car result)
                           (signal 'ftp-error
                                   (list
                                    "Opening output file"
                                    (format "FTP Error: \"%s\"" (cdr result))
                                    filename)))))
                 (ange-ftp-del-tmp-name temp)
                 (if binary
                     (ange-ftp-set-ascii-mode host user)))
               (if (eq visit t)
                   (progn
                     (set-visited-file-modtime (ange-ftp-file-modtime filename))
                     (ange-ftp-set-buffer-mode)
                     (setq buffer-file-name filename)
                     (set-buffer-modified-p nil)))
               ;; ensure `last-coding-system-used' has an appropriate value
               (setq last-coding-system-used coding-system-used)
               (ange-ftp-message "Wrote %s" abbr)
               (ange-ftp-add-file-entry filename))
           (ange-ftp-real-write-region start end filename append visit))))
     (defun ange-ftp-passive-mode (proc on-or-off)
       (if (string-match (concat "Passive mode:? " on-or-off)
                         (cdr (ange-ftp-raw-send-cmd
                               proc (concat "passive " on-or-off)
                               "Trying passive mode..." nil)))
           (ange-ftp-message (concat "Trying passive mode..." on-or-off))
         (error "Trying passive mode...failed")))))

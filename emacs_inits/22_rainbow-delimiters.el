;; rainbow-delimiters を使うための設定
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; 括弧の色を強調する設定
(custom-set-faces
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#6faeef"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#69cd69"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#ef6f6f"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#efc300"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#9d9de8"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#c99a9a"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#69cd69"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#9d9de8"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#c28d8d"))))
 '(rainbow-delimiters-mismatched-face ((t (:foreground "#88090b"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "#88090b"))))
 )

;; 以下: 括弧の色を自動設定する設定(未遂)
;; http://qiita.com/megane42/items/ee71f1ff8652dbf94cf7
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
    (cl-callf color-saturate-name (face-foreground face) 30))))
;; (add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)



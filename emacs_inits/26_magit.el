(require 'magit)
(setq magit-last-seen-setup-instructions "1.4.0")
(setq magit-auto-revert-mode nil)
(eval-after-load 'magit
  '(progn
     (set-face-background 'magit-section-highlight nil)

     (set-face-attribute 'magit-diff-hunk-heading nil
			 :foreground "blue"
			 :background nil)

     (set-face-attribute 'magit-diff-hunk-heading-highlight nil
			 :foreground "blue"
			 :background "white")

     (set-face-attribute 'magit-diff-context-highlight nil
			 :foreground "black"
			 :background "white")

     (set-face-attribute 'magit-diff-added-highlight nil
			 :foreground "white"
			 :background "green")
     (set-face-attribute 'magit-diff-removed-highlight nil
			 :foreground "red"
			 :background "green")

     (set-face-attribute 'magit-diff-added nil
			 :foreground "green"
			 :background nil)
     (set-face-attribute 'magit-diff-removed nil
			 :foreground "blue"
			 :background nil)
     ))

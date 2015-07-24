(require 'magit)
(setq magit-last-seen-setup-instructions "1.4.0")
(setq magit-auto-revert-mode nil)
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-added-highlight "white")
     (set-face-background 'magit-diff-added-highlight "green")
     (set-face-foreground 'magit-diff-removed-highlight "red")
     (set-face-background 'magit-diff-removed-highlight "green")

     (set-face-foreground 'magit-diff-added "white")
     (set-face-background 'magit-diff-added "blue")
     (set-face-foreground 'magit-diff-removed "black")
     (set-face-background 'magit-diff-removed "blue")
     ))

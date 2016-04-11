(add-hook 'matlab-mode-hook
	  '(lambda ()
	     (local-unset-key (kbd "C-h"))))

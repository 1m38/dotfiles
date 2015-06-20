;;; flymake-python-pyflakes
;;; https://github.com/purcell/flymake-python-pyflakes
(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;;pychecker を使う
(setq flymake-python-pyflakes-executable "pychecker")

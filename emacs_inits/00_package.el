;; 起動時にInstallされていないelispをpackage.elで自動インストール
;; http://kei10in.hatenablog.jp/entry/2012/09/12/220833
(require 'cl)
(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    auto-install
    company
    magit
    key-chord
    ;; ruby-end
    ;; rinari
    smartparens
    rhtml-mode
    emmet-mode
    markdown-mode
    ;; auto-save-buffers-enhanced
    real-auto-save
    helm
    helm-ls-git
    helm-descbinds
    key-combo
    ; flymake-easy
    ; flymake-python-pyflakes
    ; flymake-cursor
    flycheck
    helm-flycheck
    nav
    yatex
    open-junk-file
    elpy
    python-mode
    resize-window
    ack
    wgrep-ack
    undo-tree
    shackle
    matlab-mode
    haskell-mode
    company-ghc
    recentf-ext
    elscreen
    yasnippet
    nlinum
    ess
    rainbow-delimiters
    ))
(let ((not-installed (loop for x in installing-package-list
			   when (not (package-installed-p x))
			   collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))



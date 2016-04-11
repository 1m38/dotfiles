;; http://qiita.com/akisute3@github/items/0141c92dca0992732af8
(require 'key-combo)
(global-key-combo-mode 1)

;;; 各モードに対するキー設定
(setq key-combo-lisp-mode-hooks
      '(lisp-mode-hook
	emacs-lisp-mode-hook
	lisp-interaction-mode-hook
	inferior-gauche-mode-hook
	scheme-mode-hook))

(setq key-combo-lisp-default
      '(("."  . ("." " . " "..."))
	(","  . (key-combo-execute-orignal))
	(",@" . " ,@")
	;(";"  . (";;;; " ";"))
	("="  . ("= " "eq " "equal "))
	(">=" . ">= ")
	("(" . ("(`!!')"))
	("\"" . ("\"`!!'\"" "\""))
	))

(setq key-combo-common-mode-hooks
      '(c-mode-common-hook
	php-mode-hook
	python-mode-hook
	ruby-mode-hook
	cperl-mode-hook
	javascript-mode-hook
	js-mode-hook
	js2-mode-hook
	change-log-mode-hook
	matlab-mode-hook))

(setq key-combo-common-default
      '((","  . (", " ","))
	("="  . (" = " " == " " === " "="))
	("=>" . " => ")
	("=~" . " =~ ")
	("=*" . " =* ")
	("+"  . (" + " " += " "+"))
	("+=" . " += ")
	;("-"  . (" - " " -= " "-"))
	("-"  . ("-" " - " " -= "))
	("-=" . " -= ")
	("->" . " -> ")
	(">"  . (" > " ">"))
	(">=" . " >= ")
	("%"  . (" % " " %= " "%"))
	("%="  . " %= ")
	("!" . (" != " " !~ " "!"))
	("!="  . " != " )
	("!~" . " !~ ")
	("~" . (" =~ " "~"))
	;("::" . " :: ")
	("&"  . (" & " " && " "&"))
	("&=" . " &= ")
	("&&=" . " &&= ")
	("*"  . (" * " "**" "*"))
	("*="  . " *= " )
	("<" . (" < " "<`!!'>" "<"))
	("<=" . " <= ")
	("<<=" . " <<= ")
	("<-" . " <- ")
	;("|"  . (" ||= " " || " "|"))
	("|=" . " |= ")
	("||=" . " ||= ")
	;("/" . ("/`!!'/" " / " "// "))
	("/=" . " /= ")
	("/*" . "/* `!!' */")
	;("{" . ("{`!!'}" "{"))
	("{" . ("{`!!'}"))
	;("{|" . "{ |`!!'|  }")
	("\"" . ("\"`!!'\"" "\""))
	("'" . ("'`!!''" "'"))
	;("(" . ("(`!!')" "("))
	("(" . ("(`!!')"))
	("[" . ("[`!!']"))
	))


(key-combo-define-hook key-combo-common-mode-hooks
		       'key-combo-common-load-default
		       key-combo-common-default)
(key-combo-define-hook key-combo-lisp-mode-hooks
		       'key-combo-lisp-load-default
		       key-combo-lisp-default)

(add-to-list 'load-path "~/emacsconfig/emacs.d/plugins/yasnippet")
(require 'yasnippet)

;;(setq yas-snippet-dirs '("~/.emacs.d/snippets" "~/.emacs.d/extras/imported"))
(yas/global-mode 1)
(provide 'yasnippet-settings)

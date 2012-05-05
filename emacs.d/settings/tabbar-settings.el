
(require 'tabbar)
(tabbar-mode)
(global-set-key (kbd "C-c b") 'tabbar-backward-group)
(global-set-key (kbd "C-c f") 'tabbar-forward-group)
;;(global-set-key "\M-," 'tabbar-backward)
;;(global-set-key "\M-." 'tabbar-forward)

(provide 'tabbar-settings)

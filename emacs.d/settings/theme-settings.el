(add-to-list 'load-path
             "~/emacsconfig/emacs.d/plugins/themes")
(add-to-list 'load-path
             "~/emacsconfig/emacs.d/plugins/themes/theme-github")

;;------------------------------------------------------------------------------
;;------------------------------------------------------------------------------
;;设置字体大小 参考http://www.linuxsir.org/bbs/thread326299.html
;;(set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
(add-to-list 'default-frame-alist '(font, "-unknown-DejaVu Sans Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1"))
;; 设置另外一些颜色：语法高亮显示的背景和主题，区域选择的背景和主题，二次选择的背景和选择
;;(set-face-foreground 'highlight "white")
;;(set-face-background 'highlight "blue")
;;(set-face-foreground 'region "cyan")
;;(set-face-background 'region "blue")
;;(set-face-foreground 'secondary-selection "skyblue")
;;(set-face-background 'secondary-selection "darkblue")

(require 'color-theme)
;;(setq color-theme-is-global t)    
;;(color-theme-initialize)     

;;(color-theme-tty-dark) 
;;(load-theme 'solarized-dark t)
(require 'color-theme-solarized)
(color-theme-solarized-dark) 

(provide 'theme-settings)

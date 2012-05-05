;;------------------------------------------------------------------------------
;;GUD设置
;;------------------------------------------------------------------------------

;(global-set-key (kbd "f5") 
;    '(lambda ()
;        (interactive)
;        (text-scale-set 0)))

(add-hook 'gdb-mode-hook '(lambda ()
        (gud-tooltip-mode 1)
        (gdb-many-windows t)
        ;;(tabbar-mode nil)
        (tool-bar-mode t)
        (fullscreen)
        (menu-bar-mode nil)
        (gdb-show-changed-values t)
    )
)

;;------------------------------------------------------------------------------
;;GUD快捷键设置
;;------------------------------------------------------------------------------
(add-to-list 'load-path
             "~/emacsconfig/emacs.d/plugins/gdb")
(setq gdb-many-windows t)
;;...
;;(load-library "multi-gud.el")
(load-library "multi-gdb-ui.el")
;;(require 'gdb-ui)
;;(require 'gud)   

(defun gdb-run ()
"If gdb isn't running; run gdb, else call gud-go."                         
 (interactive) 
    (sr-speedbar-close)
    (gdb (gud-query-cmdline 'gdba))
)
    
                                                          
(defun gdb-or-gud-go2 ()                                                      
  "If gdb isn't running; run gdb, else call gud-go."                         
  (interactive)    
  ;(sr-speedbar-close)                                                          
  (if (and gud-comint-buffer                                                 
           (buffer-name gud-comint-buffer)                                   
           (get-buffer-process gud-comint-buffer)                            
           (with-current-buffer gud-comint-buffer (eq gud-minor-mode 'gdba)))
      (gud-call (if gdb-active-process "continue" "run") "") ;;then part                
    ;;else part
    (gdb-run)
  );;end:if
) 

(defun gdb-or-gud-go ()                                                      
  "If gdb isn't running; run gdb, else call gud-go."                         
  (interactive)                                                       
  (if (and gud-comint-buffer                                                 
           (buffer-name gud-comint-buffer)                                   
           (get-buffer-process gud-comint-buffer)                            
           (with-current-buffer gud-comint-buffer (eq gud-minor-mode 'gdba))) ;;if part
      ;;then part 
      (funcall (lambda ()
            (gud-call (if gdb-active-process "continue" "run") "")
            (speedbar-update-contents)
        )
      )           
    ;;else part
    (funcall(lambda ()
        ;;(sr-speedbar-close)
        (gdb (gud-query-cmdline 'gdba)))
    )
  );;end:if
)      
                                      
(defun gud-break-remove ()                                                   
  "Set/clear breakpoin."                                                     
  (interactive)                                                              
  (save-excursion                                                            
    (if (eq (car (fringe-bitmaps-at-pos (point))) 'breakpoint)               
        (gud-remove nil)                                                     
      (gud-break nil))))     
                                                      
(defun gud-kill ()                                                           
  "Kill gdb process."                                                        
  (interactive)                                                              
  (with-current-buffer gud-comint-buffer (comint-skip-input))                
  (kill-process (get-buffer-process gud-comint-buffer))) 

(defun run-project ()
    "run roject"
    (interactive)
        (setq bse (file-name-sans-extension buffer-file-name))
        ;;(compile (concat "gnome-terminal -e '" bse " && echo '按任意键继续' && read -n 1'")) ;;shell-command
        (shell-command (concat bse));; " && echo '按任意键继续' && read -n 1")) ;;shell-command
)

(defun gdb-key-settings ()                                                      
    "If gdb isn't running; run gdb, else call gud-go."                         
    (interactive)
        (global-set-key [f1] 'gud-watch)        ;;F1 查看变量
        
        (global-set-key [f5] 'gdb-or-gud-go)    ;;F5:启动GUD/GUD-go ;;F5 开始调试/go
        (global-set-key [S-f5] 'gud-kill)       ;;Shift+F5 停止调试
        (global-set-key [(C-f5)] 'run-project)  ;;Ctrl+F5 运行程序
        (global-set-key [(f8)] 'gud-until)      ;;F8 运行到光标处
        (global-set-key [f9] 'gud-break-remove) ;;F9 断点开关
        (global-set-key [f10] 'gud-next)        ;;F10 next
        (global-set-key [f11] 'gud-step)        ;;F11:setup-into
        (global-set-key [S-f11] 'gud-finish)    ;;Shift+F11:setup-out
        (global-set-key [(f12)] 'speedbar-update-contents)      ;;F12 刷新speedbar(让监视点的数据刷新为最新)
	    
)

;;------------------------------------------------------------------------------
;;GUD再下列mode下将会开启
;;------------------------------------------------------------------------------
(add-hook 'c-mode-common-hook 'gdb-key-settings)
(add-hook 'c++-mode-hook 'gdb-key-settings)
(add-hook 'go-mode-hook 'gdb-key-settings)
(add-hook 'haskell-mode-hook 'gdb-key-settings)

(provide 'gdb-settings)

;;------------------------------------------------------------------------------
;;显示时间
;;------------------------------------------------------------------------------
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)


;;==============================================================================
;;1.基本配置
;;==============================================================================
;;禁用启动画面
(setq inhibit-startup-message t)

;;设置字体大小 参考http://www.linuxsir.org/bbs/thread326299.html
;;(set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
(add-to-list 'default-frame-alist '(font, "-unknown-DejaVu Sans Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1"))

;;设定启动时窗口大小
(setq default-frame-alist 
'((height . 45) (width . 160) (top . 25) (left . 18) (menu-bar-lines . 0) (tool-bar-lines . 0))) 

;;去掉工具栏
;(tool-bar-mode nil)

;;去掉滚动条
;(scroll-bar-mode nil)

;;键绑定****************
;;WIN+s进入shell
(global-set-key (kbd "s-s") 'shell)

;;缓冲区****************
;;设定行距
(setq default-line-spacing 1)

;;页宽
(setq default-fill-column 80)

;;缺省模式
(setq default-mojor-mode 'text-mode)

;;语法加亮
(global-font-lock-mode t)

;;高亮显示区域选择
(transient-mark-mode t)

;;页面平滑滚动
(setq scroll-margin 3
 scroll-conservatively 10000)

;;高亮显示成对括号，但不来回弹跳
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;鼠标指针规避光标
;(mouse-avoidance-mode 'animate)

;;光标显示为一竖线
;(setq-default cursor-type 'bar)

;;透明
;(set-frame-parameter (selected-frame) 'alpha '(80 70))
;(add-to-list 'default-frame-alist '(alpha 95 85))

;;在标题栏提示目前我的位置
;(setq frame-title-format "zym@%b")
(setq frame-title-format `(,(user-login-name) "#" ,(system-name) "     " global-mode-string "     %f" ))

;;状态栏******************
;;标题栏显示%f缓冲区完整路径%p页面百分数%l行号
;;(setq frame-title-format "%f")

;;编辑器设定***************
;;使用X剪贴板
(setq x-select-enable-clipboard t)
;;设定剪贴板内容格式 适应firefox
(set-clipboard-coding-system 'ctext)

;;其它设置****************
;;打开图片显示功能
(auto-image-file-mode t)

(setq inhibit-startup-message t)
(tool-bar-mode nil)
(scroll-bar-mode nil)
(setq frame-title-format "%b@Emacs")

(setq default-major-mode 'text-mode)
(setq auto-image-file-mode t)
(setq make-backup-files nil)
;; 设定不产生备份文件
(setq auto-save-mode nil)
;;自动保存模式
(setq-default make-backup-files nil)
;; 不生成临时文件

;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)
(setq mouse-yank-at-point t)
(setq require-final-newline t)
(global-set-key [f4] 'other-window)

;;'y' for 'yes', 'n' for 'no'
(fset 'yes-or-no-p 'y-or-n-p)
(setq visible-bell t)



;; 全屏
(defun my-fullscreen ()
(interactive)
(x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))


(add-to-list 'load-path
             "~/.emacs.d/plugins")
;;------------------------------------------------------------------------------
;;linenum
;;------------------------------------------------------------------------------
(set-scroll-bar-mode 'right);滚动条在右侧 nil: 不显示
(require 'linum)        ;;加载相应插件       
(global-linum-mode 1)   ;;设置自动启用行号模式

(require 'swbuff)
(global-set-key (kbd "M--") 'swbuff-switch-to-previous-buffer)
(global-set-key (kbd "M-=") 'swbuff-switch-to-next-buffer)
(setq swbuff-exclude-buffer-regexps 
      '("^ " "\\*.*\\*"))

(setq swbuff-status-window-layout 'scroll)
(setq swbuff-clear-delay 1)
(setq swbuff-separator "|")
(setq swbuff-window-min-text-height 1)


;;clr 清屏
(defun eshell/cls()
  "to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))


(provide 'basic-settings)

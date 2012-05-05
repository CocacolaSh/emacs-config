(add-to-list 'load-path "~/.emacs.d/settings")
;;==============================================================================
;;Global快捷键设置
;;==============================================================================

;;F2： speedbar 外置
;;(require 'speedbar-settings)
;;(global-set-key [(f2)] 'speedbar-get-focus)

;;把speedbar集成到emacs的frame里,他会在gdb调试时 造成gdb没反应
;;(require 'sr-speedbar)
;;(global-set-key [(f2)] 'sr-speedbar-toggle)
;;(global-set-key [(f2)] 'sr-speedbar-refresh)
(require 'speedbar-settings)
;;(global-set-key [(f1)] 'speedbar-refresh)
(global-set-key [(f2)] 'speedbar-get-focus)
;;F3：切换到dired模式
(global-set-key [(f3)] 'dired)

;;F4：切换到shell模式
;(defun run-shell ()
;    "A quick run shell funciton"
;    (interactive)
;    (shell (concat "-e main"))
;)
;(global-set-key [(f4)] 'run-shell)  ;(global-set-key [(f4)] 'ansi-term)
(global-set-key [f4] (lambda () (interactive) (shell (concat "-e main") )))

;;F6：重新载入Emacs配置文件
;;(global-set-key [(f6)] (lambda () (interactive) (mapcar 'load-file ("~/.emacs")) ))

;;Alt+g: 跳转到*行
(global-set-key "\M-g" 'goto-line)

;;Alt+m: 设置备注
(global-set-key "\M-m" 'set-mark-command)

;;;Alt+F4: 关闭当前buffer
;(global-set-key (kbd "<M-f5>") (lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key (kbd "C-x M-k") (lambda () (interactive) (mapcar 'kill-buffer (buffer-list)) ))

;;;; 各窗口间切换 pnbf
;;(global-set-key (kbd "C-c <up>") 'windmove-up)
;;(global-set-key (kbd "C-c <down>") 'windmove-down)
;;(global-set-key (kbd "C-c <left>") 'windmove-left)
;;(global-set-key (kbd "C-c <right>") 'windmove-right)


;;调转到窗口的起始位置
(global-set-key (kbd "C-c H")
'(lambda () "myhome" (interactive) (move-to-window-line 0)))
(global-set-key (kbd "C-c L")
'(lambda () "myend" (interactive) (move-to-window-line -1)))

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)


;;智能编译
(require 'smart-compile)
;;(global-set-key (kbd "<f9>") 'smart-compile)
;;(global-set-key (kbd "<f10>") 'recompile)
;;(global-set-key (kbd "C-c n") 'smart-compile-next-error) 

(defun open-eshell-in-another-buffer-for-run ()
  "Open eshell in other buffer for run a program"
  (interactive)
  (setq file-extension (concat "." (file-name-extension buffer-file-name)))
  (setq file-name
	(concat "./" (replace-regexp-in-string file-extension " "  (file-name-nondirectory buffer-file-name))))
  (delete-other-windows)
  (split-window-horizontally)
  (other-window 1)
  (eshell)
  (goto-char (point-max))
  (insert file-name))
(global-set-key (kbd "C-c o") 'open-eshell-in-another-buffer-for-run)

(defun open-eshell-now ()
  "Open eshell"
  (interactive)
  (split-window-horizontally)
  (other-window 1)
  (eshell))
(global-set-key (kbd "C-c e") 'open-eshell-now)

(defun go-to-other-window-and-close-this-one()
  "Go to other window and close current window"
  (interactive)
  (other-window 1) 
  (delete-other-windows))
(global-set-key (kbd "C-c k") 'go-to-other-window-and-close-this-one)

(defun copy-current-buffer()
  "Copy crerent buffer to kill ring : by Chen Yukang"
  (interactive)
  (setq position (point))
  (kill-ring-save (point-min) (point-max))
  (goto-char position))
(global-set-key (kbd "C-c C-v") 'copy-current-buffer)


;;;; 各窗口间切换
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-c l") 'ecba)
(add-to-list 'load-path "~/.emacs.d/ecb")

(add-to-list 'load-path "~/.emacs.d/ecb")
(defun ecba ();需要的时候加载 ecb 和 cedet
  (interactive "")
  (when (locate-library "ecb")
    (require 'ecb-autoloads) ;;加载ecb
    (setq ecb-auto-activate nil
	  ecb-tip-of-the-day nil
	  ecb-tree-indent 4
	  ecb-windows-height 0.5
	  ecb-windows-width 0.18
	  ecb-auto-compatibility-check nil
	  ecb-version-check nil
	  inhibit-startup-message t))
;; cedet
  (when (locate-library "cedet")
    (require 'cedet)
    )
  (ecb-activate)
  )

(global-set-key (kbd "C-c l") 'ecba)

;;;; 隐藏和显示ecb窗口
(define-key global-map [(control f1)] 'ecb-hide-ecb-windows)
(define-key global-map [(control f2)] 'ecb-show-ecb-windows)

;;;; 使某一ecb窗口最大化
(define-key global-map [(control f5)] 'ecb-maximize-window-directories)
(define-key global-map [(control f6)] 'ecb-maximize-window-sources)
(define-key global-map [(control f7)] 'ecb-maximize-window-methods)
(define-key global-map [(control f8)] 'ecb-maximize-window-history)
(setq ecb-tip-of-the-day nil)

;;;; 恢复原始窗口布局

(define-key global-map [(control f9)] 'ecb-restore-default-window-sizes)

;;;; 自动启动ecb，并且不显示每日提示

(setq ecb-auto-activate t

      ecb-tip-of-the-day nil)

(provide 'global-keybind-settings)

;; ==================================================
;; [] match
;;Emacs 在匹配的括号之间来回跳转的时候按 C-M-f 和 C-M-b 太麻烦。
;;vi的 % 就很方便，把 % 设置为匹配括号。
;;当 % 在括号上按下时，那么匹配括号，否则输入一个 %。

(global-set-key "%" 'match-paren)
          
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
((looking-at "\\s\)") (forward-char 1) (backward-list 1))
    (t (self-insert-command (or arg 1)))))
;; end [] match

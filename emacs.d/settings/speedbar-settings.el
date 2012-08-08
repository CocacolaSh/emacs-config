;;==============================================================================
;;speedbar设置
;;==============================================================================
;; Show all files 
;;(load-file "~/.emacs.d/cedet-1.0pre7/common/cedet.el")
;;(require 'speedbar)
(setq speedbar-show-unknown-files t) 

(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)

;; switch between main frame and speedbar frame. 
;(global-set-key [(f2)] 'speedbar-get-focus) 
;;_+ 将speedbar放在window中，而不是新开frame
;; (defconst my-speedbar-buffer-name " SpeedBar")  
;; (defun my-speedbar-no-separate-frame ()
;;   (interactive)
;;   (when (not (buffer-live-p speedbar-buffer))
;;         (setq speedbar-buffer (get-buffer-create my-speedbar-buffer-name)
;;                   speedbar-frame (selected-frame)
;;                   dframe-attached-frame (selected-frame)
;;                   speedbar-select-frame-method 'attached
;;                   speedbar-verbosity-level 0
;;                   speedbar-last-selected-file nil)
;;         (set-buffer speedbar-buffer)
;;         (speedbar-mode)
;;         (speedbar-reconfigure-keymaps)
;;         (speedbar-update-contents)
;;         (speedbar-set-timer 1)
;;         (make-local-hook 'kill-buffer-hook)
;;         (add-hook 'kill-buffer-hook
;;                           (lambda () (when (eq (current-buffer) speedbar-buffer)
;;                                                    (setq speedbar-frame nil
;;                                                                  dframe-attached-frame nil
;;                                                                  speedbar-buffer nil)
;;                                                    (speedbar-set-timer nil)))))
;;   (set-window-buffer (selected-window)
;;                                          (get-buffer my-speedbar-buffer-name))) 
;; (add-hook 'speedbar-mode-hook 'my-speedbar-no-separate-frame)
;; fix speedbar in left, and set auto raise mode 
(add-hook 'speedbar-mode-hook 
    (lambda () 
        (auto-raise-mode 1) 
        (add-to-list 'speedbar-frame-parameters '(top . 30)) 
        (add-to-list 'speedbar-frame-parameters '(left . 0))
    )
) 
(sr-speedbar-refresh-turn-off)
;; inhibit tags grouping and sorting 
(setq speedbar-tag-hierarchy-method '(speedbar-simple-group-tag-hierarchy) ) 

;;最后这个的缺省值是 
;;(defcustom speedbar-tag-hierarchy-method '(speedbar-prefix-group-tag-hierarchy speedbar-trim-words-tag-hierarchy))
;;它会将tags排列、提取前缀、并分组。但通常都希望按照 tag出现行号的先后依次排列，就像vim的taglist一样， 所以改成speedbar-simple-group-tag-hierarchy。

(provide 'speedbar-settings)

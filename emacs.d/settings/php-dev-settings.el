(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;;(require 'php-completion)
(add-hook 'php-mode-hook
         (lambda ()
             (require 'php-completion)
             (php-completion-mode t)
             (define-key php-mode-base-map (kbd "C-o") 'phpcmp-complete)
             (when (require 'auto-complete nil t)
             (make-variable-buffer-local 'ac-sources)
             (add-to-list 'ac-sources 'ac-source-php-completion)
             (auto-complete-mode t))))

(provide 'php-dev-settings)

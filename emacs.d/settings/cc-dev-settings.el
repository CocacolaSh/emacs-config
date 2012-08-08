;;========================= programming ===============================
;;;;我的C/C++语言编辑策略
;; 和对应头文件之间的相互跳转。
;; 后来发现cedet的contrib/eassist.el里有这样的功能的。
(defvar associate-header-file-list '(
                                     ("cpp" . ("h" "hpp"))
                                     ("c" . ("h"))
                                     ("h" . ("cpp" "c" "cc"))
                                     ("cc" . ("h" "hpp"))
                                     ("hpp" . ("cpp" "cc"))
                                     ("C" . ("H"))
                                     ("H" . ("C" "CPP" "CC"))
                                     ))
(defun go-to-include-file ()
  "Go to assotiated.[hc] file"
  (interactive)
  (catch 'go-exit
    (let* (
           (fullname (buffer-file-name))
           (ass-suffix (cdr (assoc (file-name-extension fullname) associate-header-file-list)))
           (file (concat (file-name-sans-extension fullname) "."))
           )
      (dolist (s ass-suffix)
        (when (file-exists-p (concat file s))
          (find-file (concat file s))
          (throw 'go-exit t)))
      (message "No assotiated file")
      )))


(defun my-c-mode-common-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  (hs-minor-mode t)
;;; hungry-delete and auto-newline
  ;;(c-toggle-auto-hungry-state 1)
  ;;按键定义
  (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
  (define-key c-mode-base-map [(return)] 'newline-and-indent)
  ;;(define-key c-mode-base-map [(f7)] 'compile)
  ;;(define-key c-mode-base-map [(f8)] 'ff-get-other-file)
  (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
  ;; (define-key c-mode-base-map [(tab)] 'hippie-expand)
  (define-key c-mode-base-map [(\M o)] 'go-to-include-file)
  (define-key c-mode-base-map [(\M g)] 'cscope-find-global-definition)
  (define-key c-mode-base-map [(\M S)] 'cscope-find-this-symbol)
  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
  (define-key c-mode-base-map [meta ?/] 'semantic-ia-complete-symbol-menu)
  (define-key c-mode-base-map (kbd "C-c h") 'hs-hide-block)
  (define-key c-mode-base-map (kbd "C-c u") 'hs-show-block)
  ;;预处理设置
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  (setq abbrev-mode t)
  (setq tab-width 4 indent-tabs-mode nil)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;;;我的C++语言编辑策略
(defun my-c++-mode-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  (hs-minor-mode t)
  (c-set-style "stroustrup")
  (define-key c-mode-base-map (kbd "C-c h") 'hs-hide-block)
  (define-key c-mode-base-map (kbd "C-c u") 'hs-show-block)
  ;; (define-key c++-mode-map [f3] 'replace-regexp)
  )

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(require 'gdb-settings)
;;添加这个 使得头文件中{}缩进正确
 (c-add-style "microsoft"
              '("stroustrup"
                (c-offsets-alist
                 (innamespace . -)
                 (inline-open . 0)
                 (inher-cont . c-lineup-multi-inher)
                 (arglist-cont-nonempty . +)
                 (template-args-cont . +))))
 (setq c-default-style "microsoft")
;; c/c++ header include guard
(defun insert-include-guard ()
  "insert include guard for c and c++ header file.
for file filename.ext will generate:
#ifndef _FILENAME_EXT_
#define _FILENAME_EXT_

original buffer content

#endif//FILENAME_EXT_
"
  (interactive)
  (setq file-macro
(concat (replace-regexp-in-string "\\." "_" (concat "_" (upcase (file-name-nondirectory buffer-file-name))))))
  (setq guard-begin (concat "#ifndef " file-macro "\n"
"#define " file-macro "\n\n"))
  (setq guard-end
(concat "\n\n#endif//" file-macro "\n"))
  (setq position (point))
  (goto-char (point-min))
  (insert guard-begin)
  (goto-char (point-max))
  (insert guard-end)
  (goto-char (+ position (length guard-begin))))

;;for c/c++ ,just a makefile sample, target name: main
(defun insert-makefile-cpp ()
  (interactive)
  (setq makefile_value (concat
"CC = g++\n"
"CCD = g++ -g\n"
"TARGET = main\n"
"SOURCES = $(wildcard *.cpp)\n"
"OBJS = $(patsubst %.cpp,%.o,$(SOURCES))\n"
" \n"
"%.o:%.cpp\n"
" $(CCD) $(CFLAGS) -c $< -o $@\n"
" \n"

"main:$(OBJS)\n"
" $(CC) -O2 $(OBJS) -o $(TARGET)\n"

" \n"
"d:$(OBJS)\n"
" $(CCD) $(SOURCES) -o $(TARGET)\n"
" \n"
"clean: \n"
" @/bin/rm *.o\n"))
  (setq position (point))
  (goto-char (point-min))
  (insert makefile_value)
  (goto-char (point-max)))

(defun insert-makefile-c ()
  (interactive)
  (setq makefile_value (concat
"CC = gcc\n"
"CCD = gcc -g\n"
"TARGET = main\n"
"SOURCES = $(wildcard *.c)\n"
"OBJS = $(patsubst %.c,%.o,$(SOURCES))\n"
" \n"
"%.o:%.c\n"
" $(CCD) $(CFLAGS) -c $< -o $@\n"
" \n"

"main:$(OBJS)\n"
" $(CC) -O2 $(OBJS) -o $(TARGET)\n"

" \n"
"d:$(OBJS)\n"
" $(CCD) $(SOURCES) -o $(TARGET)\n"
" \n"
"clean: \n"
" @/bin/rm *.o\n"))
  (setq position (point))
  (goto-char (point-min))
  (insert makefile_value)
  (goto-char (point-max)))


;;自动补全部分
(add-to-list 'load-path "~/.emacs.d/company-0.5")
(autoload 'company-mode "company" nil t)
(setq company-idle-delay t)
;;set
(setq company-minimum-prefix-length 1)


(load-file "~/emacsconfig/emacs.d/cedet-1.0pre7/common/cedet.el")
(global-ede-mode 1) ; Enable the Project management system
(semantic-load-enable-code-helpers) ; Enable prototype help and smart completion
(autoload 'senator-try-expand-semantic "senator") ;;默认启动senator　


(setq semanticdb-project-roots
      (list
       (expand-file-name "/")
       (expand-file-name "~/")))


(defun my-indent-or-complete ()
  (interactive)
  (if (looking-at "\\>")
      (hippie-expand nil)
    (indent-for-tab-command)))

(semantic-load-enable-code-helpers)


(setq hippie-expand-try-functions-list
      '(
senator-try-expand-semantic
try-expand-dabbrev
try-expand-dabbrev-visible
try-expand-dabbrev-all-buffers
try-expand-dabbrev-from-kill
try-expand-list
try-expand-list-all-buffers
try-expand-line
        try-expand-line-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-whole-kill
        )
      )


(load-library "hideshow")
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'php-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)

(require 'xcscope)
(add-hook 'c-mode-common-hook
'(lambda ()
(require 'xcscope)))
(add-hook 'c++-mode-common-hook
'(lambda()
(require 'xcscope)))


;;==================== end programming ===================;
(provide 'cc-dev-settings)



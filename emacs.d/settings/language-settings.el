;;=================== the font for Chinese ===============;
(create-fontset-from-fontset-spec
  "-*-courier-medium-R-normal--18-*-*-*-*-*-fontset-mymono,
chinese-gb2312:-*-wenquanyi bitmap song-medium-*-normal--15-*-*-*-*-*-iso10646-1,
chinese-gbk:-*-wenquanyi bitmap song-medium-*-normal--15-*-*-*-*-*-iso10646-1,
chinese-gb18030:-*-wenquanyi bitmap song-medium-*-normal--15-*-*-*-*-*-iso10646-1"
   )
(setq default-frame-alist (append '((font . "fontset-mymono")) default-frame-alist))
(set-default-font "fontset-mymono")
(set-language-environment "Chinese-GB")
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(setq ansi-color-for-comint-mode t)
(provide 'language-settings)

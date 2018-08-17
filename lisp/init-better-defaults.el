;;关闭行尾警告声音
(setq ring-bell-function 'ignore)

;;git恢复后自动加载
(global-auto-revert-mode t)

;; 显示行号
(global-linum-mode 1)


;;快速简化输入
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;; signature
					    ("miao" "miaotengfei")
					    ;;Microsoft
					    ("8ms" "Microsoft")
					    ))
;;关闭自动备份
(setq make-backup-files nil)
(setq auto-save-default nil)


;;显示最近编辑过的文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 20)

;;启用自动括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;;在括号内就高亮括号
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
          (funcall fn)))))

;;选中一段文输入替换功能开启
(delete-selection-mode )

;;简化输入yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;选中区域代码缩进
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indent selected region."))
      (progn
(indent-buffer)
(message "Indent buffer.")))))

;;Hipper 补全
(setq hippie-expand-try-function-list '(try-expand-debbrev
                                        try-expand-debbrev-all-buffers
                                        try-expand-debbrev-from-kill
                                        try-complete-file-name-partially
                                        try-complete-file-name
                                        try-expand-all-abbrevs
                                        try-expand-list
                                        try-expand-line
                                        try-complete-lisp-symbol-partially
                                        try-complete-lisp-symbol))

;;Dired mode (递归删除yes)
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

(put 'dired-find-alternate-file 'disabled nil)
;;C-x C-j 就可以进入当前文件夹的所在的路径diredmode
(require 'dired-x)
;;当一个窗口（frame）中存在两个分屏 （window）时，将另一个分屏自动设置成拷贝地址的目标
(setq dired-dwin-target 1)

;;web隐藏换行符
;;(defun hidden-dos-eol ()
;;  "Do not show ^M in files containing mixed UNIX and DOS line endings."
;;  (interactive)
;;  (unless buffer-display-table
;;    (setq buffer-display-table (make-display-table)))
;;  (aset buffer-display-table ?\^M []))
;;web删除换行符
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;;配置 Occur Mode 使其默认搜索当前被选中的或者在光标下的字符串
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))


;;imenu 可以显示当前所有缓冲区的列表
(defun js2-imenu-make-index ()
      (interactive)
      (save-excursion
        ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
        (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
                                   ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
              (lambda ()
                (setq imenu-create-index-function 'js2-imenu-make-index)))
;;保存文件默认编码
(set-language-environment "UTF-8")
;;获取将当前浏览器中的 URL
(defun chrome/insert-chrome-current-tab-url()
  "Get the URL of the active tab of the first window"
  (interactive)
  (insert (chrome/retrieve-chrome-current-tab-url)))

(defun chrome/retrieve-chrome-current-tab-url()
  "Get the URL of the active tab of the first window"
  (interactive)
  (let ((result (do-applescript
		 (concat
		  "set frontmostApplication to path to frontmost application\n"
		  "tell application \"Google Chrome\"\n"
		  "	set theUrl to get URL of active tab of first window\n"
		  "	set theResult to (get theUrl) \n"
		  "end tell\n"
		  "activate application (frontmostApplication as text)\n"
		  "set links to {}\n"
		  "copy theResult to the end of links\n"
		  "return links as string\n"))))
    (format "%s" (s-chop-suffix "\"" (s-chop-prefix "\"" result)))))

;;python3 环境设置
(setq python-shell-interpreter "/usr/local/bin/python3")
(setq python-indent-guess-indent-offset nil)

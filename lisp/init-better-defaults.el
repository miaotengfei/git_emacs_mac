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

;;选中一段文输入替换功能开启
(delete-selection-mode 1)

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

(provide 'init-better-defaults)


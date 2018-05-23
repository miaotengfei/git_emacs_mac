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


(provide 'init-better-defaults)


;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)



;;高亮当前行
(global-hl-line-mode 1)


;; 更改光标的样式（不能生效，解决方案见第二集）
(setq-default cursor-type 'bar)

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;;默认开启全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))


(provide 'init-ui)

;;安装package
(when (>= emacs-major-version 24)
     ;;(require 'package)
     ;;(package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

 ;; cl - Common Lisp Extension
 (require 'cl)

 ;; Add Packages
 (defvar my/packages '(
                ;; --- Auto-completion ---
                company
                ;; --- Better Editor ---
                hungry-delete
                swiper
                counsel
                smartparens
                ;; --- Major Mode ---
                js2-mode
                ;; --- Minor Mode ---
                nodejs-repl
                exec-path-from-shell
		;; ---popwin
		popwin
                ;; --- Themes ---
                monokai-theme
                ;; solarized-theme
                ) "Default packages")

 (setq package-selected-packages my/packages)

 (defun my/packages-installed-p ()
     (loop for pkg in my/packages
           when (not (package-installed-p pkg)) do (return nil)
           finally (return t)))

 (unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
         (package-install pkg))))

 ;; Find Executable Path on OS X
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))

;;开启hungry-delete快速删除空格
(require 'hungry-delete)
(global-hungry-delete-mode)


;;smartparens右括号补全是自动加载的故注释掉
;;(require 'smartparens-config)
;; Always start smartparens mode in js-mode.
;;(add-hook 'js-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

;;swiper启用和配置 自动命令补全
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)


;;JavaScript IDE 设置
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;;寻找nodejs地址
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; 开启全局 Company 补全
(global-company-mode 1)

;;安装主题
(add-to-list 'my/packages 'monokai-theme)
;;每次打开编辑器加载主题
(load-theme 'monokai 1)

;;快速关闭打开C-h V的窗口
(require 'popwin)
(popwin-mode t)

(provide 'init-packages.el)

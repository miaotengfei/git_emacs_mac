;;cl - Common Lisp Extension
(require 'cl)
;;安装package
(when (>= emacs-major-version 24)
     ;;(require 'package)
     ;;(package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像
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

		;;---open files in finder---
		reveal-in-osx-finder

		;;other pacakges
		web-mode
		js2-refactor
		expand-region
		iedit
		org-pomodoro
		;;ag匹配搜索插件
		helm-ag
		;;语法检查器
		flycheck
		py-autopep8
		;;auto-yasnippet
		;;
		pallet
		;;语法补全
		company-anaconda
		anaconda-mode
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
;;(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
;;(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)
;; 把上面两句合起来
(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)

;;swiper启用和配置 自动命令补全
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)


;;JavaScript IDE 设置
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       '(("\\.html\\'" . web-mode))
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

;;web-mode设置初始的代码缩进
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)
;;设置web-mode在2/4个空格之间切换
(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
        (setq js-indent-level (if (= js-indent-level 2) 4 2))
        (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))
  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
             (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
             (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))
  (setq indent-tabs-mode nil))

;;js2-refactor设置
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

;;快速关闭打开C-h V的窗口
(require 'popwin)
(popwin-mode t)
;;番茄时钟
(require 'org-pomodoro)
;;语法检查器flychck
(add-hook 'js2-mode-hook 'flycheck-mode)
;;代码块补全
;; (yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)

;; enable autopep8 formatting on save
(require 'py-autopep8)(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=100"))
;;(add-hook 'python-mode-hook 'flycheck-mode)

;;python 追加补全
;; github 说明
(eval-after-load "company"
  '(add-to-list 'company-backends 'company-anaconda))

;; zilongshanren 说明
;; (add-hook 'python-mode-hook
;; 	  (lambda()
;; 	    (set (make-local-variable 'company-backends)  '((company-anaconda company-dabbrev-code ) company-dabbrev))))

;; 网络资源
;; (remove-hook 'anaconda-mode-response-read-fail-hook
;;                'anaconda-mode-show-unreadable-response)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
(progn
    '(add-to-list 'company-backends 'company-anaconda)
    ))

(global-eldoc-mode -1)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (set (make-local-variable 'company-backends)
;;                  '((company-anaconda company-dabbrev-code company-yasnippet)))))


(provide 'init-packages)

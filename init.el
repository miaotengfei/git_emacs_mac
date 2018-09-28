;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)
(require 'cask "/usr/local/Cellar/cask/0.8.4/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(add-to-list 'load-path "~/.emacs.d/lisp/")
;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(load "init-packages")
(load "init-ui")
(load "init-better-defaults")
(load "init-org")
(load "init-keybindings")


(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))


(load-file custom-file)
;; 关闭缩进 (第二天中被去除)
;; (electric-indent-mode -1)

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs2
;;(set-face-attribute 'default nil :height 160)

;;org-mode管理配置文件
(require 'org-install)
(require 'ob-tangle)
;;(org-babel-load-file (expand-file-name "org-file-name.org" user-emacs-directory))

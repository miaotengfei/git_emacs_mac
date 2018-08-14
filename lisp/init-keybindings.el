;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)
;; 设置待办事项的优先级/触发键
(global-set-key (kbd "C-c r") 'org-capture)

;;按键绑定
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(global-set-key (kbd "C-c p f") 'counsel-git)

;; 这个快捷键绑定可以用之后的插件 counsel 代替
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;;swiper 按键绑定
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
;;(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;;(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;;缩写代码补全快捷键绑定
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

;;Hipper 补全按键绑定
(global-set-key (kbd "s-/") 'hippie-expand)

;; 主动加载 Dired Mode按键绑定
;; (require 'dired)
;; (defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

;; 延迟加载按键绑定
(with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;;增强选中一个区域
(global-set-key (kbd "C-=") 'er/expand-region)
;;Occur Mode 快捷键
(global-set-key (kbd "M-s o") 'occur-dwim)
;;imenu快捷键
(global-set-key (kbd "M-s i") 'counsel-imenu)
;;iedit绑定快捷键
(global-set-key (kbd "M-s e") 'iedit-mode)

;;快速建立工作安排
(global-set-key (kbd "C-c r") 'org-capture)

;;设置web-mode在2/4个空格之间切换
(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)

;;补全时按键绑定
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))


;;ag搜索快捷键绑定
(global-set-key (kbd "C-c p s") 'helm-do-ag-project-root)

;;auto-yasnippet 快捷键设置
;;(global-set-key (kbd "H-w") #'aya-create)
;;(global-set-key (kbd "H-y") #'aya-expand)

(provide 'init-keybindings)

(defmacro on-linux (&rest x)
  `(if (string-match "linux" (prin1-to-string system-type)) (progn ,@x)))

(defmacro on-windows (&rest x)
  `(if (string-match "windows" (prin1-to-string system-type)) (progn ,@x)))

(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-set-key (kbd "<C-backspace>") 'backward-kill-word)

(setq current-language-environment "Bulgarian")
(setq default-input-method "bulgarian-phonetic")

(setq load-path
      (append load-path
              '("~/.emacs.d"
                "~/.emacs.d/progmodes"
                "~/.emacs.d/progmodes/haskell-mode-2.4"
                "~/.emacs.d/color-theme-6.6.0")))

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(global-set-key (kbd "<f11>") 'toggle-fullscreen)

(require 'maxframe)

(defun setup-frame (frame)
  (select-frame frame)
  (on-linux (set-frame-parameter frame 'font-backend '(xft x))
            (set-frame-font "Inconsolata-19")) ; "Bitstream Vera Sans Mono-13"
  (on-windows (set-frame-font "-*-Consolas-normal-r-*-*-18-*-*-*-c-*-*-iso8859-1"))
  (maximize-frame))

(add-hook 'after-make-frame-functions 'setup-frame)
(add-hook 'window-setup-hook (lambda () (setup-frame (selected-frame))))

(ido-mode 1)
(show-paren-mode 1)
(which-func-mode 1)
(line-number-mode 1)
(column-number-mode 1)
(blink-cursor-mode 1)
;; (global-hl-line-mode 1)
(transient-mark-mode 1)
(dynamic-completion-mode 1)
(auto-compression-mode 1)
(global-font-lock-mode 1)
(global-auto-revert-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)
(setq visible-bell t)
(setq bell-volume 0)
(setq case-fold-search t)
(setq make-backup-files nil)
(setq mouse-yank-at-point t)
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)
(setq dired-recursive-deletes 'top)
(setq ido-enable-flex-matching t)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq default-major-mode 'text-mode)
(setq-default tab-width 8)
(setq-default indent-tabs-mode nil)

(require 'psvn)
(require 'git)
(require 'git-blame)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(require 'linum)
(global-set-key (kbd "C-c n") 'linum-mode)

(require 'whitespace)
(global-set-key (kbd "C-c w") 'whitespace-mode)

(require 'smooth-scrolling)
(setq smooth-scroll-margin 15)

(require 'pager)
(global-set-key (kbd "C-v") 'pager-page-down)
(global-set-key (kbd "M-v") 'pager-page-up)
(global-set-key (kbd "M-p") 'pager-row-up)
(global-set-key (kbd "M-n") 'pager-row-down)

(require 'browse-kill-ring)
(global-set-key (kbd "C-c k") 'browse-kill-ring)

(require 'redo)
(global-set-key (kbd "C-/") 'undo)
(global-set-key (kbd "C-?") 'redo)

(require 'goto-last-change)
(global-set-key (kbd "C-x C-/") 'goto-last-change)

(require 'color-theme)
(color-theme-initialize)

(require 'zenburn)
(color-theme-zenburn)

;; (require 'htmlize)

(require 'doc-view)

(load "haskell-site-file")
(autoload 'mma-mode "mma.el"   "Mathematica package file mode" t)
(autoload 'rsl-mode "rsl-mode" "RenderMan Shading Language editing mode" t)
(autoload 'rib-mode "rib-mode" "RenderMan Interface Bytestream editing mode" t)
(autoload 'cg-mode  "cg-mode"  "Cg editing mode." t)
(autoload 'mel-mode "mel-mode" "Mel editting mode." t)
(autoload 'lua-mode "lua-mode" "Lua editting mode." t)

(setq lua-default-application "lua5.1")

(setq auto-mode-alist
      (append '(("\\.cs$"      . c++-mode)
                ("\\.cg$"      . cg-mode)
                ("\\.hlsl$"    . cg-mode)
                ("\\.fxh?$"    . cg-mode)
                ("\\.[gr]?sl$" . rsl-mode)
                ("\\.rib$"     . rib-mode)
                ("\\.pyg?$"    . python-mode)
                ("\\.ma$"      . mel-mode)
                ("\\.mel$"     . mel-mode)
                ("\\.ss$"      . scheme-mode)
                ("\\.lua$"     . lua-mode)
                ("\\.hs$"      . haskell-mode)
                ("\\.lhs$"     . literate-haskell-mode)
                ("\\.m$"       . mma-mode)
                ("\\.org$"     . org-mode))
              auto-mode-alist))

(add-hook
 'text-mode-hook
 (lambda ()
   (auto-fill-mode 1)
   (setq fill-column 80)))

(add-hook
 'shell-mode-hook
 (lambda ()
   (ansi-color-for-comint-mode-on)))

(add-hook
 'c-mode-hook
 (lambda ()
   (c-set-style "linux")
   (setq tab-width 8)
   (setq indent-tabs-mode t)))

(add-hook
 'c++-mode-hook
 (lambda ()
   (c-add-style
    "my-c++-style"
    '((c-basic-offset . 4)
      (c-comment-only-line-offset . 0)
      (c-offsets-alist . ((statement-block-intro . +)
                          (knr-argdecl-intro . +)
                          (substatement-open . 0)
                          (substatement-label . 0)
                          (label . 0)
                          (statement-cont . +)
                          (inline-open . 0)
                          (inexpr-class . 0)
                          (innamespace . 0)
                          (comment-intro . 0)
                          (arglist-intro . +)
                          (arglist-cont . /)
                          (arglist-close . 0)
                          (inher-intro . *)
                          (inher-cont . 0)
                          (member-init-intro . *)
                          (member-init-cont . /)))))
   (c-set-style "my-c++-style")))

(add-hook
 'haskell-mode-hook
 (lambda ()
   (setq tab-width 4)
   (turn-on-haskell-indent)
   (turn-on-haskell-doc-mode)
   (turn-on-haskell-decl-scan)
   (turn-on-haskell-ghci)))

(add-hook
 'mel-mode-hook
 (lambda ()
   (require 'etom)
   (setq etom-default-host "localhost")
   (setq etom-default-port 2323)
   (local-set-key (kbd "C-c C-r") 'etom-send-region)
   (local-set-key (kbd "C-c C-c") 'etom-send-buffer)
   (local-set-key (kbd "C-c C-l") 'etom-send-buffer)
   (local-set-key (kbd "C-c C-z") 'etom-show-buffer)))

(add-hook
 'lua-mode-hook
 (lambda ()
   (setq lua-indent-level 4)))

;; NOTE This doesn't work when done in python-mode-hook
(setq python-python-command "python3.0")

;; Cygwin setup
(on-windows
 (require 'cygwin-mount)
 (cygwin-mount-activate)
 (add-hook 'comint-output-filter-functions
           'shell-strip-ctrl-m nil t)
 (add-hook 'comint-output-filter-functions
           'comint-watch-for-password-prompt nil t)
 (setq shell-file-name "bash.exe")
 (setq explicit-shell-file-name "bash.exe"))

(message ".emacs loaded successfully.")

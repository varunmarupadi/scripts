(setq p5-use-p4config-exclusively t)
;;(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
;; '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil )))))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(global-auto-revert-mode t)
 '(inhibit-startup-screen t)
 '(show-paren-mode t))

;; Fix up the crappy font emacs uses in graphical frames
(add-to-list 'default-frame-alist '(font . "Monospace-10"))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

(load-file "/home/build/public/eng/elisp/google.el")
(add-hook 'c++-mode-hook
         '(lambda () (font-lock-set-up-width-warning 80)))
;;Gtags common commands
;;(global-set-key [(?\M-.)] 'gtags-feeling-lucky) ;; equiv: find-tag
(global-set-key [(?\M-.)] 'gtags-show-tag-locations) ;; modified to be more
                                                     ;; useful
(global-set-key [(?\M-,)] 'gtags-next-tag)      ;; equiv: tags-loop-continue
(global-set-key [(?\M-*)] 'gtags-pop-tag)       ;; equiv: pop-tag-mark
(global-set-key [f6] 'gtags-show-callers)
(global-set-key [f7] 'gtags-feeling-lucky)

(require 'google3-build)
(setq google-build-system "blaze")

(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c c") 'google3-build)
(global-set-key (kbd "C-c l") 'linum-mode)
(global-set-key (kbd "C-c o") 'g4-edit)
(global-set-key (kbd "C-x l") 'goto-line)
(global-set-key (kbd "C-x t") 'revert-buffer)

(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

(add-to-list 'load-path "~/.emacs.d")
(require 'edit-server)
(edit-server-start)

(scroll-bar-mode -1)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'org)
(org-babel-load-file (expand-file-name "~/.emacs.d/settings.org"))
;; DO NOT EDIT BEYOND THIS LINE
(show-paren-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-comment-only-line-offset 0)
 '(c-default-style (quote ((c++-mode . "ellemtel") (c-mode . "linux"))))
 '(c-hanging-braces-alist
   (quote
    ((defun-open before after)
     (defun-close before after)
     (class-open before after)
     (block-close . c-snug-do-while)
     (statement-cont)
     (substatement-open after)
     (brace-list-open)
     (brace-entry-open)
     (extern-lang-open after)
     (namespace-open)
     (namespace-close)
     (module-open after)
     (composition-open after)
     (inexpr-class-open after)
     (inexpr-class-close before)
     (arglist-cont-nonempty))))
 '(c-indent-comments-syntactically-p t)
 '(c-offsets-alist
   (quote
    ((defun-block-intro . +)
     (func-decl-cont . +)
     (knr-argdecl-intro . +)
     (topmost-intro . 0))))
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(line-number-mode nil)
 '(package-selected-packages
   (quote
    (ace-window helm-swoop ag smart-mode-line company company-go company-irony company-irony-c-headers company-rtags company-statistics datetime elpy flycheck flycheck-irony flycheck-objc-clang flycheck-rtags flycheck-ycmd flymake-json flymake-shell flyspell-correct-helm helm helm-ag helm-bm helm-codesearch helm-company helm-cscope helm-ext helm-flycheck helm-ispell helm-org-rifle helm-rtags org-autolist org-bullets org-download org-jira org-journal swiper-helm ycmd))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "white"))))
 '(company-scrollbar-fg ((t (:background "cyan"))))
 '(company-tooltip ((t (:background "black" :foreground "cyan"))))
 '(company-tooltip-selection ((t (:background "blue" :foreground "white"))))
 '(helm-grep-file ((t (:foreground "white" :underline t))))
 '(helm-grep-match ((t (:foreground "blue" :inverse-video t))))
 '(helm-rtags-token-face ((t (:foreground "green"))))
 '(helm-selection ((t (:background "magenta" :distant-foreground "red"))))
 '(helm-selection-line ((t (:inherit highlight :distant-foreground "red"))))
 '(show-paren-match ((t (:background "magenta")))))

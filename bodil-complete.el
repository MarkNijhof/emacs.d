;;; complete.el -- Auto completion

(package-require 'popup)
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories (concat dotfiles-dir "site-lisp/auto-complete/dict"))
(setq ac-auto-start nil)
(define-key ac-mode-map (kbd "C-\\") 'auto-complete)
(define-key ac-completing-map (kbd "TAB") nil)
(define-key ac-completing-map (kbd "RET") 'ac-complete)
(define-key ac-completing-map (kbd "C-\\") 'ac-complete)
;; TODO: I want PgUp/PgDn to work when AC is showing a candidate menu

;; Enable auto-complete for some modes not present by default in ac-modes
(setq ac-modes (append '(coffee-mode lolisp-mode typescript-mode
                                     nrepl-mode) ac-modes))

;; Yasnippets, always
(eval-after-load "yasnippet"
  '(setq-default ac-sources (append '(ac-source-yasnippet) ac-sources)))


;; Selective auto-complete for specific modes (see below)
;; (defun auto-complete-selective ()
;;   (interactive)
;;   (cond
;;    ((eq major-mode 'js2-mode)
;;     (tern-auto-complete))
;;
;;    (t (auto-complete))))

;;; Clojure

(package-require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "nrepl"
  '(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))

;;; Javascript

;; (require 'ac-source-tern)
;; (add-hook 'js2-mode-hook
;;           (lambda ()
;;             (add-to-list 'ac-sources 'ac-source-tern)))

(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (setq tern-ac-on-dot 1)
     (tern-ac-setup)))

(provide 'bodil-complete)

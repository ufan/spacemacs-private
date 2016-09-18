;; packages.el --- cmake-ide layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: nick <nick@acer-c710-mint>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `cmake-ide-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `cmake-ide/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `cmake-ide/pre-init-PACKAGE' and/or
;;   `cmake-ide/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(setq cmake-ide-packages
      '(cmake-ide
        irony
        company-irony
        company-irony-c-headers
        flycheck-irony
        ))

(defun cmake-ide/init-cmake-ide ()
  (use-package rtags
    :load-path cmake-ide-rtags-install-dir
    :config
    (setq rtags-use-helm t)
    (rtags-enable-standard-keybindings)
    )
  (use-package cmake-ide)
  )

;; (defun cmake-ide//init-company-rtags ()
;;   (use-package company-rtags
;;     :defer t
;;     :load-path cmake-ide-rtags-install-dir
;;     :if cmake-ide-enable-rtag
;;     :init
;;     (with-eval-after-load 'rtags
;;     '(progn
;;       (setq rtags-autostart-diagnostics t)
;;       (rtags-diagnostics)
;;       (push 'company-rtags company-backends-c-mode-common)
;;       (setq rtags-completions-enabled t)))))

;; (defun cmake-ide/post-init-flycheck ()
;;   (use-package flycheck-rtags
;;     ;; :defer t
;;     ;; :load-path cmake-ide-rtags-install-dir
;;     ;;    :load-path "/usr/local/share/emacs/site-lisp/rtags"
;;     ;; :if cmake-ide-enable-rtags
;;     :init
;;     ;;   (with-eval-after-load 'flycheck
;;     (add-hook 'c-mode-common-hook
;;               #'(lambda()
;;                   (flycheck-select-checker 'rtags)
;;                   (setq-local flycheck-check-syntax-automatically nil)
;;                   (setq-local flycheck-highlighting-mode nil)))
;;     ;;    '(add-to-list 'flycheck-checkers 'rtags)
;;     ;;                  )
;;     ))

(defun cmake-ide/init-irony ()
  (use-package irony
    :defer t
    ;; :if cmake-ide-enable-irony
    :init
    (progn
      (add-hook 'c++-mode-hook 'irony-mode)
      (add-hook 'c-mode-hook 'irony-mode)
      (add-hook 'objc-mode-hook 'irony-mode)
      (add-hook 'irony-mode-hook
                (lambda ()
                  (define-key irony-mode-map [remap completion-at-point]
                    'irony-completion-at-point-async)
                  (define-key irony-mode-map [remap complete-symbol]
                    'irony-completion-at-point-async)))
      (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
      (spacemacs|diminish irony-mode " Ⓘ" " I"))))

(defun cmake-ide/init-company-irony ()
  (use-package company-irony
    :defer t
    ;; :if cmake-ide-enable-irony
    :init
    (progn
      (with-eval-after-load 'irony
        '(push 'company-irony company-backends-c-mode-common))
      (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
      ;; The following line is neccessary(what's the reason)
      (add-hook 'irony-mode-hook 'company-mode)
      )))

(defun cmake-ide/init-company-irony-c-headers ()
  (use-package company-irony-c-headers
    :defer t
    ;; :if cmake-ide-enable-irony
    :init
    (progn
      (if (member 'company-irony company-backends-c-mode-common)
          (setq company-backends-c-mode-common (delete 'company-irony company-backends-c-mode-common)))
      (push '(company-irony-c-headers company-irony) company-backends-c-mode-common))))

(defun cmake-ide/init-flycheck-irony ()
  (use-package flycheck-irony
    ;; :defer t
    ;; :if cmake-ide-enable-irony
    :init
    (progn
      (with-eval-after-load 'flycheck
        '(add-to-list 'flycheck-checkers 'irony)))))

(defun cmake-ide/post-init-cmake-ide ()
  (cmake-ide-setup)
  )

;;; packages.el ends here

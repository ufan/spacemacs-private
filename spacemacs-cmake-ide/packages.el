;;; packages.el --- cmake-ide layer packages file for Spacemacs.
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

;; (defconst spacemacs-cmake-ide-packages
;;   '(cmake-ide company-irony irony flycheck-rtags)
;;         )

(setq spacemacs-cmake-ide-packages
      '(cmake-ide
        irony
        company-irony
        ;; flycheck-rtags
        ;; flycheck-irony
        ;; company-irony-c-headers
        ))

(defun spacemacs-cmake-ide/init-cmake-ide ()
  (use-package cmake-ide))

(defun spacemacs-cmake-ide/init-irony ()
  (use-package irony
    :defer t
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

;; (when (configuration-layer/package-usedp 'company)
  (defun spacemacs-cmake-ide/init-company-irony ()
    (use-package company-irony
      :defer t
      :init
      (progn
        (push 'company-irony company-backends-c-mode-common)
        (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
        )
      ))
;; )

(defun spacemacs-cmake-ide/post-init-cmake-ide ()
  (require 'rtags)
  (cmake-ide-setup))

(defun spacemacs-cmake-ide/post-init-irony ()
  )


(defun spacemacs-cmake-ide/post-init-company-irony ()
  )
;;; packages.el ends here

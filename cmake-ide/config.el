;;; config.el --- Spacemacs cmake-ide Layer config File for Spacemacs
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; variables

(defvar cmake-ide-enable-irony t
  "If non nil , irony-mode/company-irony/company-irony-c-headers/flycheck-irony will be used")

(defvar cmake-ide-enable-rtags t
  "If non nil, the company-rtags/flycheck-rtags will be used")

(defvar cmake-ide-rtags-install-dir  "/usr/local/share/emacs/site-lisp/rtags")

(setq editorconfig-packages
      '(editorconfig))

(defun editorconfig/init-editorconfig ()
  (use-package editorconfig
    :config
    (progn
      (spacemacs|diminish editorconfig-mode)
      (editorconfig-mode 1))))

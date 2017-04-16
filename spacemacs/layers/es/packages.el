(setq es-packages
      '(
        rjsx-mode
        emmet-mode
        evil-matchit
        smartparens
        add-node-modules-path
        flycheck
        js-doc
        ))

(defun es/init-rjsx-mode ()
  (use-package rjsx-mode
    :defer t
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
      (add-hook 'rjsx-mode-hook (setq emmet-expand-jsx-className? t)))
    ))

(defun es/post-init-emmet-mode ()
  (add-hook 'rjsx-mode-hook 'emmet-mode))

(defun es/post-init-evil-matchit ()
  (with-eval-after-load 'evil-matchit
    (plist-put evilmi-plugins 'rjsx-mode
               '((evilmi-simple-get-tag evilmi-simple-jump)
                 (evilmi-javascript-get-tag evilmi-javascript-jump)
                 (evilmi-html-get-tag evilmi-html-jump)))))

(defun es/post-init-smartparens ()
  (if dotspacemacs-smartparens-strict-mode
      (add-hook 'rjsx-mode-hook #'smar
tparens-strict-mode)
  (add-hook 'rjsx-mode-hook #'smartparens-mode)))

(defun es/init-add-node-modules-path ()
  (use-package add-node-modules-path
    :defer t
    :init
    (progn
      (with-eval-after-load 'rjsx-mode
        (add-hook 'rjsx-mode-hook #'add-node-modules-path)))))

(defun es/post-init-flycheck ()
  (with-eval-after-load 'flycheck
    (push 'javascript-jshint flycheck-disabled-checkers))
  (spacemacs/add-flycheck-hook 'rjsx-mode))

(defun es/post-init-js-doc ()
  (add-hook 'rjsx-mode-hook 'spacemacs/js-doc-require)
  (spacemacs/js-doc-set-key-bindings 'rjsx-mode))

;; -*- lexical-binding: t; -*-
;; Não faça backup automático
(setf backup-inhibited 1)
;; Não suje meu init.el emacs, use esse aqui!
(setq custom-file "~/.emacs.d/custom.el")
(column-number-mode 1)
(menu-bar-mode -1)
;; cópias também vão para o clipboard
(require 'xclip)
(xclip-mode 1)
;; auto complete
(require 'company)
(global-company-mode)
;; ido deixa o find-file ou switch-to-buffer mais dinâmico
;; (ido-mode)
;; (ido-everywhere 1)
;; ffap melhora o fluxo de encontrar arquivos e permite abrir arquivos sobre o ponto de forma direta
(require 'ffap)
(ffap-bindings)
;; Normalmente o alt+shift é visto como alt pelo emacs, faça-lhe diferenciar 
(with-eval-after-load 'term
  ; Se quiser mapear outras, use C-q para visualizar o código
  (define-key input-decode-map "\e[1;4A" [M-S-up])
  (define-key input-decode-map "\e[1;4B" [M-S-down]))
;; Minhas funções
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))
(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))
;; Meus atalhos
(global-set-key (kbd "M-S-<up>") 'scroll-other-window-down)
(global-set-key (kbd "M-S-<down>") 'scroll-other-window)
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ; mova em sentido anti-horário
;; Permita que modificações de temas seja aplicada ao final e efetivamente seja aplicadas
(load-file "~/.emacs.d/custom.el")

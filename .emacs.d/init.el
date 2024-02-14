;
; ░▀█▀░█▀█░▀█▀░▀█▀░░░░█▀▀░█░░
; ░░█░░█░█░░█░░░█░░░░░█▀▀░█░░
; ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░░▀▀▀░▀▀▀
;

; Minimal orgmode configuration to export in neovim

(require 'org)

(setq org-todo-keywords
  '((sequence "TODO" "INFO" "NEXT" "WAIT" "|" "DONE" "DROP")))

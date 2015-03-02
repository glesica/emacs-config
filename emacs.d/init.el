;; --------------------
;; Visual Modifications
;; --------------------

;; Hide the tool bar
(menu-bar-showhide-tool-bar-menu-customize-disable)

;; Hide the scroll bars
(scroll-bar-mode -1)

;; Set the color theme
(load-theme 'tango-dark t)

;; ------------------
;; Package Management
;; ------------------

;; Set up MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Install packages
(unless (package-installed-p 'elixir-mode)
  (package-install 'elixir-mode))

(unless (package-installed-p 'company)
  (package-install 'company))

(unless (package-installed-p 'go-mode)
  (package-install 'go-mode))

(unless (package-installed-p 'flycheck)
  (package-install 'flycheck))

(unless (package-installed-p 'neotree)
  (package-install 'neotree))

;; -------
;; Company
;; -------

(company-mode)

;; -------
;; Go-mode
;; -------

(setenv "GOPATH" "~/Workspace/Go")
(setenv "PATH" (concat (getenv "PATH")
		       ":"
		       (getenv "GOPATH") "/bin"))
(add-to-list 'exec-path
	     (concat (getenv "GOPATH") "/bin"))
(add-to-list 'load-path
	     (concat (getenv "GOPATH")
		     "/src/github.com/dougm/goflymake"))
(require 'go-flycheck)

;; ------------
;; Key bindings
;; ------------

(global-set-key "\C-x\C-d" 'kill-whole-line)

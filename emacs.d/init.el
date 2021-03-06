;; ----------------
;; Useful functions
;; ----------------

(defun home-directory ()
  (getenv "HOME"))

(defun home-sub-directory (sub)
  "Returns the absolute path to a file or directory within the home directory."
  (concat (home-directory) "/" sub))

(defun add-to-path (dir)
  "Adds a directory to both the PATH env variable and the exec-path list."
  (setenv "PATH" (concat (getenv "PATH")
			 ":"
			 dir))
  (add-to-list 'exec-path dir))

(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files unless they have been modified."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
	(revert-buffer t t t))))
  (message "Refreshed open files."))

;; --------------------
;; Visual Modifications
;; --------------------

;; Hide the tool bar
(menu-bar-showhide-tool-bar-menu-customize-disable)

;; Hide the scroll bars
(scroll-bar-mode -1)

;; Set the color theme
(load-theme 'tango-dark t)

;; Turn on line numbers
(global-linum-mode t)

;; ------------
;; Interactions
;; ------------

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; ----------
;; Path stuff
;; ----------

(add-to-path "/usr/local/bin")

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

(unless (package-installed-p 'alchemist)
  (package-install 'alchemist))

(unless (package-installed-p 'erlang)
  (package-install 'erlang))

(unless (package-installed-p 'yaml-mode)
  (package-install 'yaml-mode))

(unless (package-installed-p 'julia-mode)
  (package-install 'julia-mode))

(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))

(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))

;; -------
;; Company
;; -------

(company-mode)

;; -----------
;; Elixir-mode
;; -----------

(when (string-equal system-type "darwin")
  (add-to-path "Workspace/elixir/bin"))

;; -------
;; Go-mode
;; -------
(setenv "GOPATH"
	(cond
	 ((string-equal system-type "darwin")
	  (home-sub-directory "Workspace/Go"))
	 ((string-equal system-type "gnu/linux")
	  (home-sub-directory "Go"))))
(add-to-path (concat (getenv "GOPATH") "/bin"))
(shell-command "go get -u github.com/dougm/goflymake")
(add-to-list 'load-path
	     (concat (getenv "GOPATH")
		     "/src/github.com/dougm/goflymake"))
(require 'go-flycheck)

;; -------
;; Neotree
;; -------

(global-set-key [f8] 'neotree-toggle)

;; ------
;; Erlang
;; ------

(add-to-list 'auto-mode-alist
	     '("relx.config" . erlang-mode))

;; ---------
;; Undo-tree
;; ---------

(global-undo-tree-mode)

;; ------------
;; Key bindings
;; ------------

(global-set-key "\C-x\C-d" 'kill-whole-line)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

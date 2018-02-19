(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defvar my-packages '(better-defaults
                      use-package
		      projectile
		      clojure-mode
		      cider
		      ace-window))

;; Load / install packages
(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

;; Load configuration file for each package
;; each config file lives in "<package-name>.el"
(defun load-user-file (file)
  (interactive "f")
  "Load a file in current users's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(dolist (p my-packages)
  (let ((filename (concat (symbol-name p) ".el")))
    (if (file-exists-p (expand-file-name filename user-init-dir))
        (load-user-file filename))))

;; Full screen
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(toggle-fullscreen)

;; IntelliJ darcula theme
(use-package darcula-theme
  :ensure t
  :config
  ;; your preferred main font face here
  (set-frame-font "Inconsolata-14"))

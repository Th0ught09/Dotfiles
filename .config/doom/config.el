;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "IosevkaTerm Nerd Font" :size 20 :weight 'semi-light))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq user-mail-address "kirkmatt@proton.me")
(use-package mu4e
  :defer 20 ; Wait until 20 seconds after startup
  :config

  (setq mu4e-change-filenames-when-moving t ; avoid sync conflicts
      mu4e-update-interval (* 10 60) ; check mail 10 minutes
      mu4e-compose-format-flowed t ; re-flow mail so it's not hard wrapped
      mu4e-get-mail-command "mbsync -a"
      mu4e-maildir "~/Mail/ProtonMail"
      user-mail-address "kirkmatt@proton.me")

  (setq mu4e-drafts-folder "/Drafts"
      mu4e-sent-folder   "/Sent"
      mu4e-refile-folder "/All Mail"
      mu4e-trash-folder  "/Trash")

  (setq mu4e-maildir-shortcuts
      '(("/inbox"     . ?i)
        ("/Sent"      . ?s)
        ("/Trash"     . ?t)
        ("/Drafts"    . ?d)
        ("/All Mail"  . ?a)))

  (setq message-send-mail-function 'smtpmail-send-it
      auth-sources '("~/.authinfo") ;need to use gpg version but only local smtp stored for now
      smtpmail-smtp-server "127.0.0.1"
      smtpmail-smtp-service 1025
      smtpmail-stream-type  'plain))

(require 'ox-publish)
(setq org-publish-project-alist
      '(
        ("org-notes"
        :base-directory "~/org/"
        :base-extension "org"
        :publishing-directory "~/public_html/"
        :recursive t
        :publishing-function org-html-publish-to-html
        :headline-levels 4             ; Just the default for this project.
        :auto-preamble t
        )

        ("org-static"
        :base-directory "~/org/"
        :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
        :publishing-directory "~/public_html/"
        :recursive t
        :publishing-function org-publish-attachment
        )
        ("org" :components ("org-notes" "org-static"))      ;; ... add all the components here (see below)...
      ))

(defun calendar-helper () ;; doesn't have to be interactive
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "Purple")
    (cfw:ical-create-source "Uni" "https://scientia-eu-v4-api-d3-02.azurewebsites.net//api/ical/b5098763-4476-40a6-8d60-5a08e9c52964/33ff0a46-42c9-fa35-e710-20a89e30a8cd/timetable.ics" "Red")
    (cfw:ical-create-source "Life" "https://calendar.proton.me/api/calendar/v1/url/1RZQ6qxSo4AGgUOR_cCVlj9d_KXgckkAdOEN0wszIXMvSXALutYgoIiNWltRW2q5_EUdfmwf4zwM2wYdDIPdCA==/calendar.ics?CacheKey=CuxtvSb__5z15LJQckBW7w%3D%3D&PassphraseKey=cHyl07vC-qgAdoCiCQZZZvcItem-zCk6fYfdCnn1_E4%3D" "Black"))))

(defun calendar-init ()
  ;; switch to existing calendar buffer if applicable
  (if-let (win (cl-find-if (lambda (b) (string-match-p "^\\*cfw:" (buffer-name b)))
                           (doom-visible-windows)
                           :key #'window-buffer))
      (select-window win)
    (calendar-helper)))
(defun =my-calendar ()
  "Activate (or switch to) *my* `calendar' in its workspace."
  (interactive)
  (if (featurep! :ui workspaces) ;; create workspace (if enabled)
      (progn
        (+workspace-switch "Calendar" t)
        (doom/switch-to-scratch-buffer)
        (calendar-init)
        (+workspace/display))
    (setq +calendar--wconf (current-window-configuration))
    (delete-other-windows)
    (switch-to-buffer (doom-fallback-buffer))
    (calendar-init)))

(custom-set-variables
 '(org-directory "~/org")
 '(org-agenda-files (list "~/org/agenda/"))
 '(diary-file "~/org/diary.org"))


(setq org-tag-alist (quote ((:startgroup)
                            ("@uniLibrary". ?u)
                            ("@home" . ?h)
                            (:endgroup))))

(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-roam-directory (file-truename "~/org"))
;=================================================================
; VIM BINDINGS
;=================================================================

(setq tab-width 4)
(setq evil-shift-width 4)

;=================================================================
; Packages
;=================================================================

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


;=================================================================
; Variables
;=================================================================

(setq yas-snippet-dirs '("~/.config/emacs/snippets"))


;=================================================================
; Home page
; =================================================================

; (use-package dashboard
;     :config
;         (dashboard-setup-startup-hook)
;     :custom
;         (dashboard-startup-banner 'logo)
;         (dashboard-banner-logo-title nil)
;         (dashboard-icon-type 'nerd-icons)
;         (dashboard-set-heading-icons t)
;         (dashboard-set-file-icons t)
;         (dashboard-set-footer nil)
;         (dashboard-projects-backend 'projectile)
;         (dashboard-display-icons-p t)
;         (dashboard-items '(
;             (recents . 5)
;             (agenda . 5)
;             (projects . 5)
;             (bookmarks . 5)
; )))

;=================================================================
; Emms
; =================================================================
(emms-all)
(setq emms-player-list '(emms-player-mpv)
      emms-info-functions '(emms-info-native))

;=================================================================
; Hooks
; =================================================================
(add-hook 'org-mode-hook 'abbrev-hook)
(add-hook 'minibuffer-mode-hook 'abbrev-hook)
(add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)
(defun abbrev-hook ()
  (abbrev-mode 1))

;=================================================================
; Constants
; =================================================================
(setq! abbrev-file-name "~/Dotfiles/.config/doom/abbrev_defs")
(setq! scroll-margin 8)
(setq! find-file-visit-truename nil)
(setq evil-shift-width 4)
(setq emms-source-file-default-directory "~/music/")
(setq company-mode nil)
(setq emms-repeat-playlist t)
;; (setq mode-line-format '("%e" (:eval (doom-modeline-format--main))))
;(setq mode-line-format nil)
(setq org-icalendar-timezone "Europe/London")
(setq emms-repeat-playlist t)
(setq centaur-tabs-mode nil)
(setq yas-snippet-dirs '("~/Dotfiles/.config/doom/snippets"))
(setq ob-mermaid-cli-path "~/.nix-profile/bin/keybindings")

;=================================================================
; mmdc
; =================================================================
(define-key ctl-x-map "p" 'emms-pause)
(define-key ctl-x-map "P" 'org-pomodoro)
(global-set-key (kbd "M-i") 'ace-window)
(global-set-key (kbd "C-c f") 'org-roam-node-find)
(global-set-key (kbd "C-c i") 'org-roam-node-insert)
(global-set-key (kbd "C-c d m") 'org-roam-dailies-goto-tomorrow)
(global-set-key (kbd "C-c d t") 'org-roam-dailies-goto-today)
(global-set-key (kbd "C-c p d") 'org-pdfview-store-link)
(global-set-key (kbd "M-C-h") help-map)
(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-l") 'windmove-right)
(global-set-key (kbd "C-j") 'windmove-down)
(global-set-key (kbd "C-k") 'windmove-up)
(global-set-key (kbd "<normal state> L") 'centaur-tabs-forward)
(global-set-key (kbd "<normal state> H") 'centaur-tabs-backward)
(local-unset-key (kbd "C-j"))
(local-unset-key (kbd "C-k"))
(local-unset-key (kbd "S-l"))
(local-unset-key (kbd "S-h"))
(require 's)

;=================================================================
; Calendar sync
; =================================================================
;;; define categories that should be excluded
(setq org-export-exclude-category (list "google" "private"))

;;; define filter. The filter is called on each entry in the agenda.
;;; It defines a regexp to search for two timestamps, gets the start
;;; and end point of the entry and does a regexp search. It also
;;; checks if the category of the entry is in an exclude list and
;;; returns either t or nil to skip or include the entry.

(defun org-mycal-export-limit ()
  "Limit the export to items that have a date, time and a range. Also exclude certain categories."
  (setq org-tst-regexp "<\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} ... [0-9]\\{2\\}:[0-9]\\{2\\}[^\r\n>]*?\
\)>")
  (setq org-tstr-regexp (concat org-tst-regexp "--?-?" org-tst-regexp))
  (save-excursion
    ; get categories
    (setq mycategory (org-get-category))
    ; get start and end of tree
    (org-back-to-heading t)
    (setq mystart    (point))
    (org-end-of-subtree)
    (setq myend      (point))
    (goto-char mystart)
    ; search for timerange
    (setq myresult (re-search-forward org-tstr-regexp myend t))
    ; search for categories to exclude
    (setq mycatp (member mycategory org-export-exclude-category))
    ; return t if ok, nil when not ok
    (if (and myresult (not mycatp)) t nil)))

;;; activate filter and call export function
(defun org-mycal-export ()
  (let ((org-icalendar-verify-function 'org-mycal-export-limit))
   (org-export-icalendar-combine-agenda-files)))

;=================================================================
; Org
; =================================================================
(add-hook 'org-mode-hook
          (lambda ()
            (evil-define-key 'normal org-mode-map (kbd "C-k") nil)
            (evil-define-key 'normal org-mode-map (kbd "C-j") nil)))

(add-hook 'evil-mode-hook
          (lambda ()
            (evil-define-key 'normal evil-org-mode-map (kbd "S-h") nil)
            (evil-define-key 'normal evil-org-mode-map (kbd "S-l") nil)))

(define-key evil-motion-state-map (kbd "H") nil)
(define-key evil-motion-state-map (kbd "L") nil)

(add-to-list 'org-agenda-custom-commands
             '("b" agenda "Today's Deadlines"
               ((org-agenda-span 'day)
                (org-agenda-skip-function '(org-agenda-skip-deadline-if-not-today))
                (org-agenda-entry-types '(:deadline))
                (org-agenda-overriding-header "Today's Deadlines "))))

(defun org-agenda-skip-deadline-if-not-today ()
"If this function returns nil, the current match should not be skipped.
Otherwise, the function must return a position from where the search
should be continued."
  (ignore-errors
    (let ((subtree-end (save-excursion (org-end-of-subtree t)))
          (deadline-day
            (time-to-days
              (org-time-string-to-time
                (org-entry-get nil "DEADLINE"))))
          (now (time-to-days (current-time))))
       (and deadline-day
            (not (= deadline-day now))
            subtree-end))))

;; (defun get-pdf-page ()
;;   )

;=================================================================
; TODO
; =================================================================
(setq org-todo-keywords '((sequence "TODO" "|" "DONE" "HOLD")
                          (sequence "PRAC" "|" "COMP")))

;=================================================================
; roam refile
; =================================================================

(defun roam-tomorrow-refile ()(org-refile ('format-time-string "~/org/%Y-%m-%d.org" (time-add (current-time) (days-to-time 1)))))
(defun org-pdfview-store-link ()
  "Store a link to a pdfview buffer."
  (interactive)
  (when (eq major-mode 'pdf-view-mode)
    ;; This buffer is in pdf-view-mode
    (let* ((path buffer-file-name)
           (page (pdf-isearch-current-page))
           (link (concat "pdf:" path "::" (number-to-string page))))
      (org-link-store-props
       :type "pdf"
       :link link
       :description  (concat path " :: Page #" (number-to-string page))))))

(defun pdf-find()
  (interactive)
  (find-file "~/books/"))

(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-j") 'windmove-down)
    (define-key map (kbd "C-k") 'windmove-up)
    map)
  "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "C-j") nil)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 0)
(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer
          (delq (current-buffer)
                (seq-filter 'buffer-file-name (buffer-list)))))

;; (defun my-minibuffer-setup-hook ()
;;   (my-keys-minor-mode 0))

;; (add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)
  (advice-remove #'org-babel-do-load-languages #'ignore)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t) ;; Other languages
     (shell . t)
     (python . t)
     (jupyter . t)))

(require 'org-src)
(require 'ob-async)
(require 'ob-ipython-autoloads)
(require 'ob-jupyter)
(require 'jupyter)
(require 'jupyter-org-client)

(after! (ob-jupyter)
  (org-babel-jupyter-aliases-from-kernelspecs))
;;config.el
(require 'ob-python)
(use-package jupyter
  :demand t
  :after (:all org python)
)

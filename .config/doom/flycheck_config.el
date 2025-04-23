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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
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
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; Each path is relative to the path of the maildir you passed to mu
;(set-email-account! "protonmail"
;  '((mu4e-sent-folder       . "/ProtonMail/Sent")
;    (mu4e-drafts-folder     . "/ProtonMail/Drafts")
;    (mu4e-trash-folder      . "/ProtonMail/Trash")
;    (mu4e-refile-folder     . "/ProtonMail/All Mail")
;    (smtpmail-smtp-user     . "kirkmatt@proton.me")
;    (mu4e-compose-signature . "Kind Regards,\nKirkm"))
;  t)
;(setq mu4e-smtp-server "127.0.0.1")
;(setq mu4e-smtp-port 1025)
;(setq mu4e-smtp-user "kirkmatt@proton.me")
;(setq mu4e-smtp-auth 'plain)  ;; Or 'login if that works
;(setq mu4e-smtp-tls nil)
;(add-to-list 'load-path "/home/kirkm/.config/emacs/.local/straight/build-29.4/evil-collection/modes")
;(add-to-list 'load-path "/home/kirkm/.config/emacs/.local/straight/build-29.4/evil-collection/modes/mu4e")

;(setq smtpmail-smtp-server "127.0.0.1")
;(setq smtpmail-smtp-service 1025)
;(setq user-full-name "Kirk Matt")
;(setq mail-user-agent 'message-user-agent)
(setq user-mail-address "kirkmatt@proton.me")
;(setq sendmail-program "/home/kirkm/.nix-profile/bin/msmtp"
;      send-mail-function 'message-send-mail-with-sendmail)
;(setq smtpmail-smtp-user "kirkmatt@proton.me")
;(setq user-mail-address "kirkmatt@proton.me")
;(setq mu4e-smtp-server "127.0.0.1"
;      mu4e-smtp-user "kirkmatt@proton.me"
;      mu4e-smtp-port 1025
;      mu4e-smtp-auth 'plain)
;(setq smtpmail-smtp-user "kirkmatt@proton.me")
;(setq smtpmail-default-smtp-server "127.0.0.1")
;(setq smtpmail-smtp-service 1025)
;(setq sendmail-program "/home/kirkm/.nix-profile/bin/msmtp")
;(setq send-mail-function 'message-send-mail-with-sendmail)
;(setq smtpmail-auth-credentials (expand-file-name "~/.msmtprc"))
;(setq smtpmail-smtp-tls nil) ;; Disable TLS if ProtonMail Bridge does not use it
(use-package mu4e
  :defer 20 ; Wait until 20 seconds after startup
  :config

  (setq mu4e-change-filenames-when-moving t ; avoid sync conflicts
      mu4e-update-interval (* 10 60) ; check mail 10 minutes
      mu4e-compose-format-flowed t ; re-flow mail so it's not hard wrapped
      mu4e-get-mail-command "mbsync -a"
      mu4e-maildir "~/Mail/ProtonMail"
      user-mail-address "kirkmatt@proton.me")

  (setq mu4e-drafts-folder "/ProtonMail/Drafts"
      mu4e-sent-folder   "/ProtonMail/Sent"
      mu4e-refile-folder "/ProtonMail/All Mail"
      mu4e-trash-folder  "/ProtonMail/Trash")

  (setq mu4e-maildir-shortcuts
      '(("/ProtonMail/inbox"     . ?i)
        ("/ProtonMail/Sent"      . ?s)
        ("/ProtonMail/Trash"     . ?t)
        ("/ProtonMail/Drafts"    . ?d)
        ("/ProtonMail/All Mail"  . ?a)))

  (setq message-send-mail-function 'smtpmail-send-it
      auth-sources '("~/.authinfo") ;need to use gpg version but only local smtp stored for now
      smtpmail-smtp-server "127.0.0.1"
      smtpmail-smtp-service 1025
      smtpmail-stream-type  'plain))

(require 'ox-publish)
(setq org-publish-project-alist
      '(
        ("org-notes"
        :base-directory "~/Documents/Org/"
        :base-extension "org"
        :publishing-directory "~/public_html/"
        :recursive t
        :publishing-function org-html-publish-to-html
        :headline-levels 4             ; Just the default for this project.
        :auto-preamble t
        )

        ("org-static"
        :base-directory "~/Documents/Org/"
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

;(setq org-agenda-files (list "~/Documents/Org"))

(custom-set-variables
 '(org-directory "~/Documents/Org")
 '(org-agenda-files (list org-directory)))


(setq org-tag-alist (quote ((:startgroup)
                            ("@uniLibrary". ?u)
                            ("@home" . ?h)
                            (:endgroup))))

(setq org-default-notes-file (concat org-directory "/notes.org"))

;=================================================================
; VIM BINDINGS
;=================================================================

(setq tab-width 4)
;; (setq display-line-numbers
;; 'relative)
(setq linum-relative-current-symbol "")


;=================================================================
; Packages
;=================================================================

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;=================================================================
; Variables
;=================================================================

(setq yas-snippet-dirs '("~/.config/emacs/snippets"))
(define-abbrev-table 'global-abbrev-table
 '(
    ("vi" "vim" nil :count 2)
    ("emc" "emacs" nil :count 2)
    ("emcas" "emacs is ass" nil :count 2)
   ))


;=================================================================
; Home page
; =================================================================

(use-package dashboard
    :config
        (dashboard-setup-startup-hook)
    :custom
        (dashboard-startup-banner 'logo)
        (dashboard-banner-logo-title nil)
        (dashboard-icon-type 'nerd-icons)
        (dashboard-set-heading-icons t)
        (dashboard-set-file-icons t)
        (dashboard-set-footer nil)
        (dashboard-projects-backend 'projectile)
        (dashboard-display-icons-p t)
        (dashboard-items '(
            (recents . 10)
            (agenda . 10)
            (projects . 10)
            (bookmarks . 10)
)))

emc
